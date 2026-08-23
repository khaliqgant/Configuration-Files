#!/bin/bash
# aw-disk-cleanup.sh — daily SAFE disk reclamation for the AgentWorkforce Macs.
# Safe-only by design: caches (rebuildable) + NON-FORCE git worktree removal.
# `git worktree remove` (no --force) refuses any worktree with tracked-modified
# or non-ignored-untracked files, so uncommitted/untracked work is NEVER lost,
# and every removed worktree's committed branch stays in its parent clone.
# Installed + scheduled by install-aw-disk-cleanup.sh (launchd, daily 13:00).
set -uo pipefail

# launchd runs with a minimal env — establish a usable PATH (incl. mise shims).
export PATH="$HOME/.local/share/mise/shims:/opt/homebrew/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"

PROJECTS="$HOME/Projects/AgentWorkforce"
DATA_VOL="/System/Volumes/Data"

log() { printf '%s  %s\n' "$(date '+%Y-%m-%d %H:%M:%S')" "$*"; }
free_kib() { df -k "$DATA_VOL" | tail -1 | awk '{print $4}'; }
human_gib() { awk -v k="$1" 'BEGIN{printf "%.1fG", k/1024/1024}'; }

log "=== aw-disk-cleanup start ($(hostname -s)) ==="
before=$(free_kib)
log "free before: $(human_gib "$before")"

# 1) npm cache (fully rebuildable)
if command -v npm >/dev/null 2>&1; then
  npm cache clean --force >/dev/null 2>&1 && log "npm cache cleaned" || log "npm cache clean failed (skipped)"
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
        /private/tmp/*) continue ;;           # ephemeral / possibly-active sessions
      esac
      [ -d "$wt" ] || continue
      if git -C "$repo" worktree remove "$wt" >/dev/null 2>&1; then
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
