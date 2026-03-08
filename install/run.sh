#!/usr/bin/env bash

if [[ "$1" == "--dry-run" ]]; then
    dry="echo"
else
    dry=""
fi

# export dry for the other scripts
export dry=$dry

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

echo "copying iterm fonts"
$dry cp -R iterm/fonts/source-code-pro-1.017R/* /Library/Fonts/

echo "copying over terminal setting"
$dry open ./terminal/profiles/dev.terminal
$dry defaults write com.apple.terminal "Default Window Settings" "dev"

cd install
echo "setting macOS defaults"
bash macos-defaults.sh
echo "downloading cli and vim items"
bash shell.sh
echo "setting vim settings"
bash vim.sh
echo "downloading homebrew and cask apps"
bash apps.sh
echo "setting up languages via mise"
bash mise-setup.sh
echo "cloning my repos"
bash repos.sh
echo "setting up npm global packages"
bash npms.sh
echo "installing pips"
bash pip.sh
echo "installing gems"
bash gem.sh
echo "installing CLI tools (claude, amp)"
bash cli-tools.sh
echo "restoring mackup settings"
$dry mackup restore
echo "starting mysql"
bash mysql.sh
echo "setup installed apps"
bash app_setup.sh
