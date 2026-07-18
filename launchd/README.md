# launchd — scheduled local jobs

## aw-disk-cleanup

Daily **safe** disk reclamation for the AgentWorkforce Macs. Runs every day at **13:00**
via a per-user LaunchAgent.

**What it does (safe-only — never destroys uncommitted work):**
1. `npm cache clean --force`
2. `rm -rf ~/.cache/codex-runtimes`
3. NON-FORCE `git worktree remove` across every top-level clone in `~/Projects/AgentWorkforce`.
   `git worktree remove` (no `--force`) refuses any worktree with tracked-modified or
   non-ignored-untracked files, so real work is preserved; removed worktrees keep their
   committed branch in the parent clone. Skips `/private/tmp` worktrees.

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
