#!/usr/bin/env bash

MISE_BIN="${MISE_BIN:-/opt/homebrew/bin/mise}"
RUN="$MISE_BIN exec --"

packages=$(<data/gems.txt)

for package in $packages
do
    if $RUN gem list -i "$package" &>/dev/null; then
        echo "$package already installed, skipping"
    else
        $dry $RUN gem install "$package"
    fi
done

if ! $RUN gem list -i jekyll &>/dev/null; then
    $dry $RUN gem install bundler jekyll
fi
