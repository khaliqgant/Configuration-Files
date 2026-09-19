#!/usr/bin/env bash

# Install Homebrew if not already installed
if ! command -v brew &>/dev/null; then
    echo "Installing Homebrew"
    # NONINTERACTIVE skips the "Press RETURN to continue" prompt, which a stray
    # keypress (e.g. a terminal focus escape sequence) can turn into an abort.
    # run.sh already cached sudo, which the non-interactive installer requires.
    NONINTERACTIVE=1 $dry /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    if [[ -x /opt/homebrew/bin/brew ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    elif [[ -x /usr/local/bin/brew ]]; then
        eval "$(/usr/local/bin/brew shellenv)"
    fi
    if [[ -z "$dry" ]] && ! command -v brew &>/dev/null; then
        echo "Error: Homebrew install failed, brew not found. Fix and rerun: bash install/run.sh --from=apps"
        exit 1
    fi
else
    echo "Homebrew already installed, skipping"
fi

export HOMEBREW_CASK_OPTS="--appdir=/Applications"

# Install everything from the Brewfile (formulae + casks)
echo "Installing brew formulae and cask apps from Brewfile"
cd ..

# Homebrew refuses to load formulae from untrusted third-party taps, so tap and
# trust every tap declared in the Brewfile before bundling.
while read -r tap; do
    $dry brew tap "$tap"
    $dry brew trust "$tap"
done < <(sed -n "s/^tap '\([^']*\)'.*/\1/p" Brewfile)

$dry brew bundle
cd -

# Start services
$dry brew services start mysql
