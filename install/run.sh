#!/usr/bin/env bash

set -e

if [[ $EUID -eq 0 ]]; then
    echo "Error: do not run this script with sudo. Run as your normal user: bash install/run.sh"
    exit 1
fi

dry=""
from=""
for arg in "$@"; do
    case "$arg" in
        --dry-run) dry="echo" ;;
        --from=*)  from="${arg#--from=}" ;;
    esac
done

# export dry for the other scripts
export dry=$dry

# Steps in order — used by --from to skip ahead
steps=(fonts terminal macos-defaults shell vim apps mackup mise repos npms pip gem cli-tools mysql app-setup)

# skip=1 until we reach the requested step
if [[ -n "$from" ]]; then
    skip=1
    valid=0
    for s in "${steps[@]}"; do [[ "$s" == "$from" ]] && valid=1; done
    if [[ $valid -eq 0 ]]; then
        echo "Unknown step '$from'. Valid steps: ${steps[*]}"
        exit 1
    fi
else
    skip=0
fi

# Helper: returns true if we should run this step
should_run() {
    local step="$1"
    if [[ $skip -eq 1 ]]; then
        [[ "$step" == "$from" ]] && skip=0
        [[ $skip -eq 1 ]] && return 1
    fi
    return 0
}

# Create ~/Dropbox symlink to the actual Dropbox path
# Update DROPBOX_PATH below to match your Dropbox folder location
DROPBOX_PATH="$HOME/Ingliq Dropbox/Khaliq Gant"
if [ ! -L ~/Dropbox ] && [ -d "$DROPBOX_PATH" ]; then
    echo "Creating ~/Dropbox symlink"
    $dry ln -sf "$DROPBOX_PATH" ~/Dropbox
elif [ -L ~/Dropbox ]; then
    echo "~/Dropbox symlink already exists, skipping"
fi

# Ask for sudo password upfront and keep alive
if [[ -z "$dry" ]]; then
    echo "Some steps require sudo. Enter your password now:"
    sudo -v
    # Keep sudo alive in the background
    while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &
fi

if should_run fonts; then
    echo "copying iterm fonts"
    $dry sudo cp -R iterm/fonts/source-code-pro-1.017R/* /Library/Fonts/
fi

if should_run terminal; then
    echo "copying over terminal setting"
    $dry open ./terminal/profiles/dev.terminal
    $dry defaults write com.apple.terminal "Default Window Settings" "dev"
fi

cd install

if should_run macos-defaults; then
    echo "setting macOS defaults"
    bash macos-defaults.sh
fi

if should_run shell; then
    echo "downloading cli and vim items"
    bash shell.sh
fi

if should_run vim; then
    echo "setting vim settings"
    bash vim.sh
fi

if should_run apps; then
    echo "downloading homebrew and cask apps"
    bash apps.sh
fi

# Ensure Homebrew-installed tools (e.g. mackup) are on PATH
# /opt/homebrew = Apple Silicon, /usr/local = Intel
if [[ -x /opt/homebrew/bin/brew ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
fi

if should_run mackup; then
    echo "restoring mackup settings (before symlinks so dotfiles take priority)"
    # Pre-delete directories that mackup will replace with Dropbox symlinks.
    # Python 3.14's shutil.rmtree has a macOS compatibility issue where it calls
    # os.unlink() on directory entries (getting EPERM), so we remove them first
    # with the shell's rm -rf which handles this correctly.
    if [ -d ~/.vim/bundle ] && [ ! -L ~/.vim/bundle ]; then
        echo "Removing ~/.vim/bundle before mackup restore (avoids Python 3.14 shutil bug)"
        $dry chflags -R nouchg ~/.vim/bundle
        $dry chmod -R u+w ~/.vim/bundle
        $dry rm -rf ~/.vim/bundle
    fi
    $dry mackup restore
fi

if should_run mise; then
    echo "setting up languages via mise"
    bash mise-setup.sh
fi

if should_run repos; then
    echo "cloning my repos"
    bash repos.sh
fi

if should_run npms; then
    echo "setting up npm global packages"
    bash npms.sh
fi

if should_run pip; then
    echo "installing pips"
    bash pip.sh
fi

if should_run gem; then
    echo "installing gems"
    bash gem.sh
fi

if should_run cli-tools; then
    echo "installing CLI tools (claude, amp)"
    bash cli-tools.sh
fi

if should_run mysql; then
    echo "starting mysql"
    bash mysql.sh
fi

if should_run app-setup; then
    echo "setup installed apps"
    bash app_setup.sh
fi
