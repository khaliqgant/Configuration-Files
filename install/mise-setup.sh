#!/usr/bin/env bash

PYTHON_VERSION="${PYTHON_VERSION:=3.12.4}"
NODE_VERSION="${NODE_VERSION:=22}"
RUBY_VERSION="${RUBY_VERSION:=3.3.0}"

# Activate mise in current shell
eval "$(mise activate bash)"

echo "Installing Node.js $NODE_VERSION via mise"
$dry mise use --global node@"$NODE_VERSION"

echo "Installing Python $PYTHON_VERSION via mise"
$dry mise use --global python@"$PYTHON_VERSION"

echo "Installing Ruby $RUBY_VERSION via mise"
$dry mise use --global ruby@"$RUBY_VERSION"

echo "Installing Go via mise"
$dry mise use --global go@latest

echo "Installing Rust via mise"
$dry mise use --global rust@latest
