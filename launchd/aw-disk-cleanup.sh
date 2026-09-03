#!/bin/bash
# aw-disk-cleanup.sh — daily SAFE disk reclamation for the AgentWorkforce Macs.
# Safe-only by design: caches (rebuildable) + NON-FORCE git worktree removal.
# `git worktree remove` (no --force) refuses any worktree with tracked-modified
# or non-ignored-untracked files, so uncommitted/untracked work is NEVER lost,
# and every removed worktree's committed branch stays in its parent clone.
# Worktrees under /private/tmp are included, but only once idle for
# TMP_MIN_AGE_H hours (default 12) — see the case arm below.
# Installed + scheduled by install-aw-disk-cleanup.sh (launchd, 4x/day).
set -uo pipefail

# launchd runs with a minimal env — establish a usable PATH (incl. mise shims).
export PATH="$HOME/.local/share/mise/shims:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

PROJECTS="$HOME/Projects/AgentWorkforce"
DATA_VOL="/System/Volumes/Data"
# Minimum idle age before a /private/tmp worktree may be removed (hours).
TMP_MIN_AGE_H="${TMP_MIN_AGE_H:-12}"

log() { printf '%s  %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*"; }
free_kib() { df -k "$DATA_VOL" | tail -1 | awk '{print $4}'; }
human_gib() { awk -v k="$1" 'BEGIN{printf "%.1fG", k/1024/1024}'; }

# Run a command under a wall-clock limit, killing its whole process group on
# expiry. macOS ships no timeout(1) and neither mini has coreutils, so this is
# hand-rolled. This matters more than it looks: launchd will not start a second
# instance of a job that is still running, so ONE wedged step silently cancels
# every later scheduled run. finn-mini sat with `npm cache clean` hung for
# ~2 days that way, skipping ~8 scheduled cleanups, with no error in the log —
# just a start line and no matching done line. Every fallible step runs here.
run_limited() {
  local secs="$1" name="$2"; shift 2
  local pid rc waited=0
  set -m                                    # give the child its own process group
  "$@" >/dev/null 2>&1 &
  pid=$!
  set +m
  while kill -0 "$pid" 2>/dev/null; do
    if [ "$waited" -ge "$secs" ]; then
      kill -TERM "-$pid" 2>/dev/null || kill -TERM "$pid" 2>/dev/null
      sleep 2
      kill -KILL "-$pid" 2>/dev/null || kill -KILL "$pid" 2>/dev/null
      wait "$pid" 2>/dev/null
      log "TIMEOUT after ${secs}s: $name (killed)"
      return 124
    fi
    sleep 1
    waited=$((waited+1))
  done
  wait "$pid"; rc=$?
  return "$rc"
}

log "=== aw-disk-cleanup start ($(hostname -s)) ==="
before=$(free_kib)
log "free before: $(human_gib "$before")"

# 1) npm cache (fully rebuildable)
if command -v npm >/dev/null 2>&1; then
  run_limited 120 "npm cache clean" npm cache clean --force \
    && log "npm cache cleaned" || log "npm cache clean failed/timed out (skipped)"
fi

# 1b) npx package cache — NOT touched by `npm cache clean`, and the bigger of the
# two in practice (seen at 4.2G while _cacache was only 125M). Fully rebuildable:
# npx re-fetches each package on next use.
if [ -d "$HOME/.npm/_npx" ]; then
  npx_kib=$(du -sk "$HOME/.npm/_npx" 2>/dev/null | awk '{print $1}')
  rm -rf "$HOME/.npm/_npx" && log "removed ~/.npm/_npx ($(human_gib "${npx_kib:-0}"))"
fi

# 2) codex runtimes cache (re-downloads on demand)
if [ -d "$HOME/.cache/codex-runtimes" ]; then
  rm -rf "$HOME/.cache/codex-runtimes" && log "removed ~/.cache/codex-runtimes"
fi

# 3) NON-FORCE git worktree removal across every clone in Projects (see below —
#    owners are not always top-level).
if [ -d "$PROJECTS" ]; then
  removed=0; skipped=0
  # A full pass is O(100 owners) and each remove can take 30-90s; cap the phase
  # so it always finishes well inside the 4-hourly schedule.
  wt_deadline=$(( $(date +%s) + 40*60 ))
  # Owners are any dir with a .git DIRECTORY (a true clone, not a worktree's .git
  # file). They are NOT always top-level: a top-level dir can be a plain CONTAINER
  # holding the real clone one or two levels down (e.g. relay/checkout, with 14
  # worktrees hanging off it, or customer-agents/<repo>). An earlier version only
  # checked "$PROJECTS"/*/.git and silently skipped every such owner — 36G of
  # worktrees under one container had never been cleaned. Descend to depth 3.
  while IFS= read -r repo; do
    while IFS= read -r wt; do
      [ -n "$wt" ] || continue
      case "$wt" in
        "$repo") continue ;;                  # the main checkout itself
        /private/tmp/*)
          # /private/tmp is where the bulk of reclaimable worktrees now live:
          # agent task dirs (relay-*-MMDD, cloud-*, wt-*) and Claude Code
          # scratchpad worktrees (/private/tmp/claude-501/<proj>/<session>/...).
          # This used to be skipped wholesale as "ephemeral / possibly-active",
          # which left the script unable to touch what became the DOMINANT source
          # of growth — a manual pass on 2026-09-03 reclaimed 45G, and 19 of the
          # 23 worktrees it removed were under /private/tmp that this script had
          # walked straight past. Now allowed, but only once the worktree root has
          # sat untouched for TMP_MIN_AGE_H hours, so an in-flight session is left
          # alone. Two further guards still apply: non-force remove refuses any
          # dirty worktree, and a live Claude agent worktree is LOCKED, which
          # non-force remove also refuses on its own.
          wt_mtime=$(stat -f %m "$wt" 2>/dev/null) || continue
          if [ $(( ( $(date +%s) - wt_mtime ) / 3600 )) -lt "$TMP_MIN_AGE_H" ]; then
            skipped=$((skipped+1))
            continue
          fi
          ;;
      esac
      [ -d "$wt" ] || continue
      if [ "$(date +%s)" -ge "$wt_deadline" ]; then
        log "worktree phase deadline hit — stopping early (partial pass)"
        break 2
      fi
      if run_limited 120 "worktree remove $wt" git -C "$repo" worktree remove "$wt"; then
        log "removed worktree: $wt"
        removed=$((removed+1))
      else
        skipped=$((skipped+1))                # dirty/untracked -> preserved
      fi
    done < <(git -C "$repo" worktree list --porcelain 2>/dev/null | awk '/^worktree /{print $2}')
    git -C "$repo" worktree prune >/dev/null 2>&1
  done < <(find "$PROJECTS" -mindepth 2 -maxdepth 4 -type d -name .git -not -path '*/node_modules/*' 2>/dev/null | sed 's|/\.git$||')
  log "worktrees removed=$removed  skipped(dirty)=$skipped"
fi

after=$(free_kib)
delta=$(( after - before ))
log "free after:  $(human_gib "$after")  (reclaimed $(human_gib "$delta"))"
log "=== aw-disk-cleanup done ==="
