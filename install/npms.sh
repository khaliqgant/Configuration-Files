#!/usr/bin/env bash

packages=$(<data/npm.txt)

# puppeteer (used by mintlify) needs this directory to exist
mkdir -p ~/.cache/puppeteer

for package in $packages
do
    if npm list -g "$package" &>/dev/null; then
        echo "$package already installed, skipping"
    else
        $dry npm install -g --force "$package"
    fi
done
