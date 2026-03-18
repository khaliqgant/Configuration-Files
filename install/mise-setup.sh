#!/usr/bin/env bash

PYTHON_VERSION="${PYTHON_VERSION:=3.12.4}"
NODE_VERSION="${NODE_VERSION:=22}"
RUBY_VERSION="${RUBY_VERSION:=3.3.0}"

# Activate mise in current shell
eval "$(mise activate bash)"

echo "Installing languages via mise (versions defined in mise.toml)"
$dry mise install
