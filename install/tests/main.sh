#!/usr/bin/env bash

# Full dry-run test for the install scripts
# Runs run.sh with --dry-run and verifies output contains expected commands

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DIR="$(dirname "$SCRIPT_DIR")"

echo "=== Running full dry-run ==="
output=$(cd "$INSTALL_DIR/.." && bash install/run.sh --dry-run 2>&1)

errors=0

check_output() {
    if echo "$output" | grep -q "$1"; then
        echo "  PASS: found '$1'"
    else
        echo "  FAIL: missing '$1'"
        errors=$((errors + 1))
    fi
}

echo ""
echo "=== Checking expected commands in output ==="

# Fonts
check_output "cp -R iterm/fonts"

# macOS defaults
check_output "defaults write com.apple.dock"
check_output "defaults write NSGlobalDomain KeyRepeat"
check_output "defaults write com.apple.finder"

# Symlinks
check_output "ln -sf"

# Homebrew
check_output "brew bundle"

# mise
check_output "mise use --global node"
check_output "mise use --global python"
check_output "mise use --global ruby"
check_output "mise use --global rust"
check_output "mise use --global go"

# npm
check_output "npm install -g"

# pip
check_output "pip install"

# gems
check_output "gem install"

# mysql
check_output "brew services start mysql"

# mackup
check_output "mackup restore"

echo ""
if [ $errors -gt 0 ]; then
    echo "=== $errors check(s) FAILED ==="
    exit 1
else
    echo "=== All checks PASSED ==="
fi
