#!/usr/bin/env bash

# Use mise's ruby explicitly rather than relying on PATH or mise exec
MISE_BIN="${MISE_BIN:-/opt/homebrew/bin/mise}"
if RUBY_PATH=$("$MISE_BIN" which ruby 2>/dev/null); then
    export PATH="$(dirname "$RUBY_PATH"):$PATH"
else
    echo "Warning: mise ruby not found, using system ruby ($(ruby --version))"
fi

echo "Using ruby: $(ruby --version) at $(which ruby)"

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
