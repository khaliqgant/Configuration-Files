#!/usr/bin/env bash

# Find mise-installed ruby directly from the install directory
RUBY_VERSION=$(ls "$HOME/.local/share/mise/installs/ruby/" 2>/dev/null | sort -V | tail -1)
if [ -n "$RUBY_VERSION" ]; then
    export PATH="$HOME/.local/share/mise/installs/ruby/$RUBY_VERSION/bin:$PATH"
    echo "Using mise ruby $RUBY_VERSION at $(which ruby)"
else
    echo "Warning: mise ruby not found, using system ruby"
fi

packages=$(<data/gems.txt)

for package in $packages
do
    if gem list -i "$package" &>/dev/null; then
        echo "$package already installed, skipping"
    else
        $dry gem install "$package"
    fi
done

if ! gem list -i jekyll &>/dev/null; then
    $dry gem install bundler jekyll
fi
