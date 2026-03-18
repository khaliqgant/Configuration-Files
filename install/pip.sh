#!/usr/bin/env bash

$dry python3 -m ensurepip --upgrade 2>/dev/null
packages=$(<data/pips.txt)

for package in $packages
do
    if python3 -m pip show "$package" &>/dev/null; then
        echo "$package already installed, skipping"
    else
        $dry python3 -m pip install --break-system-packages "$package"
    fi
done
