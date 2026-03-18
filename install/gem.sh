#!/usr/bin/env bash

eval "$(mise activate bash)"

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
    $dry gem install --user-install bundler jekyll
fi
