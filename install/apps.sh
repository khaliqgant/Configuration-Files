#!/usr/bin/env bash

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew"
    $dry /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "Homebrew already installed, skipping"
fi

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Install everything from the Brewfile (formulae + casks)
echo "Installing brew formulae and cask apps from Brewfile"
cd ..
$dry brew bundle
cd -

# Start services
$dry brew services start mysql
$dry brew services start mailhog
