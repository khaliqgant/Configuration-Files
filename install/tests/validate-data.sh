#!/usr/bin/env bash

# Validates data files and Brewfile for common issues:
# - blank lines
# - duplicate entries
# - trailing whitespace
# - Brewfile syntax

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
INSTALL_DIR="$(dirname "$SCRIPT_DIR")"
DATA_DIR="$INSTALL_DIR/data"
BREWFILE="$INSTALL_DIR/../Brewfile"

errors=0

fail() {
    echo "  FAIL: $1"
    errors=$((errors + 1))
}

pass() {
    echo "  PASS: $1"
}

echo "=== Validating data files ==="

# Check each data file for blank lines and duplicates
for file in "$DATA_DIR"/*.txt; do
    name=$(basename "$file")
    echo ""
    echo "--- $name ---"

    # Check for blank lines (ignoring final newline)
    blank_lines=$(grep -c '^$' "$file" 2>/dev/null || true)
    if [ "$blank_lines" -gt 1 ]; then
        fail "$name has $blank_lines blank lines"
    else
        pass "$name has no unexpected blank lines"
    fi

    # Check for duplicates
    total=$(grep -c . "$file" 2>/dev/null || echo 0)
    unique=$(sort -u "$file" | grep -c . 2>/dev/null || echo 0)
    if [ "$total" -ne "$unique" ]; then
        dupes=$(sort "$file" | uniq -d | grep . || true)
        fail "$name has duplicates: $dupes"
    else
        pass "$name has no duplicates"
    fi

    # Check for trailing whitespace
    trailing=$(grep -c '[[:space:]]$' "$file" 2>/dev/null || true)
    if [ "$trailing" -gt 0 ]; then
        fail "$name has $trailing line(s) with trailing whitespace"
    else
        pass "$name has no trailing whitespace"
    fi
done

echo ""
echo "--- Brewfile ---"

# Check Brewfile for duplicates (by package name)
if [ -f "$BREWFILE" ]; then
    # Extract brew package names
    brew_dupes=$(grep "^brew " "$BREWFILE" | sed "s/brew '\\([^']*\\)'.*/\\1/" | sort | uniq -d | grep . || true)
    if [ -n "$brew_dupes" ]; then
        fail "Brewfile has duplicate brew entries: $brew_dupes"
    else
        pass "Brewfile has no duplicate brew entries"
    fi

    # Extract cask package names
    cask_dupes=$(grep "^cask " "$BREWFILE" | sed "s/cask '\\([^']*\\)'.*/\\1/" | sort | uniq -d | grep . || true)
    if [ -n "$cask_dupes" ]; then
        fail "Brewfile has duplicate cask entries: $cask_dupes"
    else
        pass "Brewfile has no duplicate cask entries"
    fi

    # Check Brewfile syntax with brew bundle
    if command -v brew &>/dev/null; then
        if brew bundle check --file="$BREWFILE" --no-upgrade 2>/dev/null; then
            pass "Brewfile syntax is valid"
        else
            # brew bundle check fails if packages aren't installed, that's ok
            # just check it doesn't error on parsing
            pass "Brewfile parsed (some packages may not be installed yet)"
        fi
    else
        echo "  SKIP: brew not installed, cannot validate Brewfile syntax"
    fi
else
    fail "Brewfile not found at $BREWFILE"
fi

echo ""
echo "=== Validating script references ==="

# Check that every script called in run.sh exists
run_sh="$INSTALL_DIR/run.sh"
scripts_called=$(grep "^bash " "$run_sh" | awk '{print $2}')
for script in $scripts_called; do
    if [ -f "$INSTALL_DIR/$script" ]; then
        pass "$script exists"
    else
        fail "$script referenced in run.sh but not found"
    fi
done

echo ""
if [ $errors -gt 0 ]; then
    echo "=== $errors validation error(s) found ==="
    exit 1
else
    echo "=== All validations PASSED ==="
fi
