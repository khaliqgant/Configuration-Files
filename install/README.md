# New Computer Setup Install Scripts
Oh, new computer?? You fancy huh?

## Fresh Install Steps

### 1. Install Dropbox
- Download and install [Dropbox](https://www.dropbox.com/install) manually
- Sign in and wait for your Dropbox folder to sync (this has your SSH keys, npmrc, etc.)

### 2. Run Dropbox setup script
This copies over your SSH keys, npmrc, and installs oh-my-zsh:
```bash
bash ~/Dropbox/KJG/Install/setup.sh
```
Note: If `~/Dropbox` doesn't exist yet, the install script (step 4) will create a symlink from `~/Dropbox` to your actual Dropbox folder. You can also create it manually:
```bash
ln -sf ~/path/to/your/Dropbox ~/Dropbox
```

### 3. Clone this repo
```bash
mkdir -p ~/Configuration-Files
git clone git@github.com:khaliqgant/Configuration-Files.git ~/Configuration-Files
```

### 4. Run the install
```bash
cd ~/Configuration-Files
bash install/run.sh
```
You'll be prompted for your sudo password once at the start. After that, everything runs automatically.

### 5. Manual installs
After the script finishes, install the apps listed in [Manual Installs](#manual-installs-not-available-via-homebrew) below.

### 6. Restart
Log out and back in (or restart) for all macOS defaults to take effect.

## What gets installed
* **Shell** - oh-my-zsh, zsh plugins (syntax highlighting, autosuggestions, completions), dotfile symlinks
* **Vim** - spf13-vim, copilot.vim, undo directory
* **Homebrew** - all formulae and cask apps from the unified Brewfile
* **Languages** - Node, Python, Ruby, Go, Rust via [mise](https://mise.jdx.dev/)
* **Packages** - global npm, pip, and gem packages
* **macOS** - dock, keyboard, trackpad, Finder, screenshot preferences
* **Services** - MySQL, Mailhog
* **Config sync** - mackup restore for app settings

## Re-running
All scripts are idempotent. You can safely re-run `install/run.sh` to pick up any changes without duplicating work.

## Dry run
Preview what will be installed without making changes:
```bash
cd ~/Configuration-Files
bash install/run.sh --dry-run
```

## Tests
```bash
cd ~/Configuration-Files/install
bash tests/run-all.sh       # run everything
bash tests/validate-data.sh # lint data files and Brewfile
bash tests/main.sh          # full dry-run integration test
```

## Manual Installs (not available via Homebrew)
These apps need to be installed manually after setup:
* [BetterSnapTool](https://apps.apple.com/app/bettersnaptool/id417375580) - Mac App Store
* [iBar](https://apps.apple.com/app/ibar-menubar-icon-control-tool/id6443843900) - Mac App Store
* [Next Meeting](https://apps.apple.com/app/next-meeting/id1017470484) - Mac App Store
* [XDeck](https://xdeck.app) - Direct download
* [Codex Mac App](https://developers.openai.com/codex/app/) - Direct download
* [Conductor](https://conductor.build) - Direct download
* [Superset](https://superset.sh/) - Direct download
