# launchd — scheduled local jobs

## aw-disk-cleanup

**Safe** disk reclamation for the AgentWorkforce Macs. Runs 4x/day at **09:00, 13:00, 17:00,
21:00** via a per-user LaunchAgent (bumped from once-daily on 2026-08-18 — worktree backlog
was outpacing a single daily run).

**What it does (safe-only — never destroys uncommitted work):**
1. `npm cache clean --force`
2. `rm -rf ~/.npm/_npx` — the npx package cache, which `npm cache clean` does **not** touch
   and is usually the larger of the two (seen at 4.2G vs 125M for `_cacache`). Rebuildable.
3. `rm -rf ~/.cache/codex-runtimes`
4. NON-FORCE `git worktree remove` across every clone in `~/Projects/AgentWorkforce`.
   Owners are found by searching for `.git` **directories** to depth 3 — they are *not*
   always top-level. A top-level dir can be a plain container holding the real clone
   below it (`relay/checkout`, `customer-agents/<repo>`); the old top-level-only check
   silently skipped those, leaving 36G of worktrees under one container uncleaned.
   `git worktree remove` (no `--force`) refuses any worktree with tracked-modified or
   non-ignored-untracked files, so real work is preserved; removed worktrees keep their
   committed branch in the parent clone. Skips `/private/tmp` worktrees.

**Every fallible step runs under a wall-clock watchdog** (`run_limited`; macOS has no
`timeout(1)` and the minis have no coreutils). This is not belt-and-braces: launchd will
not start a job that is already running, so a single wedged step silently cancels every
later scheduled run. finn-mini sat with `npm cache clean` hung for ~2 days that way and
skipped ~8 cleanups, leaving no error in the log — only a start line with no matching
done line. **To spot it: `grep -c 'start' log` vs `grep -c 'done' log` should match.**
The worktree phase also has a 40-minute overall deadline and logs when it stops early.

It deliberately does **not** delete `~/.agentworkforce/burn`, force-remove worktrees, or
dedup session clones — those need a human.

### Install / update (idempotent)
```bash
bash launchd/install-aw-disk-cleanup.sh
```

### Manage
```bash
launchctl kickstart -k gui/$(id -u)/com.khaliqgant.aw-disk-cleanup   # run now
cat ~/Library/Logs/aw-disk-cleanup.log                               # see runs
launchctl list | grep aw-disk-cleanup                                # status ('-' idle, PID running)
launchctl bootout gui/$(id -u)/com.khaliqgant.aw-disk-cleanup        # disable
```

Deployed on: this Mac, sf-mini, finn-mini.
