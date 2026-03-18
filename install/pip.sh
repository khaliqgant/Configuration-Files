#!/usr/bin/env bash

PYTHON_VERSION=$(ls "$HOME/.local/share/mise/installs/python/" 2>/dev/null | sort -V | tail -1)
if [ -n "$PYTHON_VERSION" ]; then
    export PATH="$HOME/.local/share/mise/installs/python/$PYTHON_VERSION/bin:$PATH"
fi

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
