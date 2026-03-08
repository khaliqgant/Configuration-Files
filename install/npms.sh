#!/usr/bin/env bash

packages=$(<data/npm.txt)

for package in $packages
do
    if ! npm list -g "$package" &>/dev/null; then
        $dry npm install -g "$package"
    else
        echo "$package already installed, skipping"
    fi
done
