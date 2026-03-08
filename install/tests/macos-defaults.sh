#!/usr/bin/env bash
export dry="echo"
(cd "$(dirname "$0")/.." && bash macos-defaults.sh)
