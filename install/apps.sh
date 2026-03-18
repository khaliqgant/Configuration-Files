#!/usr/bin/env bash

# Homebrew cannot run as root. If this script is invoked via sudo, run brew
# commands as the original user.
if [[ $EUID -eq 0 && -n "$SUDO_USER" ]]; then
    BREW_RUN="sudo -u $SUDO_USER"
else
    BREW_RUN=""
fi

# Install Homebrew if not already installed
if ! $BREW_RUN command -v brew &>/dev/null; then
    echo "Installing Homebrew"
    $dry $BREW_RUN /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    $dry $BREW_RUN eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo "Homebrew already installed, skipping"
fi

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Install everything from the Brewfile (formulae + casks)
echo "Installing brew formulae and cask apps from Brewfile"
cd ..
$dry $BREW_RUN brew bundle
cd -

# Start services
$dry $BREW_RUN brew services start mysql
$dry $BREW_RUN brew services start mailhog
