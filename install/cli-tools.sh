#!/usr/bin/env bash

echo "Installing Claude Code CLI"
if command -v claude >/dev/null 2>&1; then
    echo "claude already installed, skipping"
else
    $dry bash -c 'curl -fsSL https://claude.ai/install.sh | bash'
fi

echo "Installing Amp"
if command -v amp >/dev/null 2>&1; then
    echo "amp already installed, skipping"
else
    $dry bash -c 'curl -fsSL https://ampcode.com/install.sh | bash'
fi

echo "Installing Cursor"
if command -v cursor >/dev/null 2>&1; then
    echo "cursor already installed, skipping"
else
    $dry bash -c 'curl -fsSL https://cursor.com/install | bash'
fi

echo "Installing Kiro"
if command -v kiro >/dev/null 2>&1; then
    echo "kiro already installed, skipping"
else
    $dry bash -c 'curl -fsSL https://cli.kiro.dev/install | bash'
fi
