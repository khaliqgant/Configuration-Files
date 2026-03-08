#!/usr/bin/env bash

# Runs all tests: data validation, dry-run checks, and individual script dry-runs

set -e

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

echo "========================================"
echo "  Data & Config Validation"
echo "========================================"
bash "$SCRIPT_DIR/validate-data.sh"

echo ""
echo "========================================"
echo "  Full Dry-Run Integration Test"
echo "========================================"
bash "$SCRIPT_DIR/main.sh"

echo ""
echo "========================================"
echo "  Individual Script Dry-Runs"
echo "========================================"

for test in apps npms repos shell symlinks vim gem pip mysql macos-defaults mise-setup; do
    test_file="$SCRIPT_DIR/$test.sh"
    if [ -f "$test_file" ]; then
        echo ""
        echo "--- $test ---"
        if bash "$test_file" >/dev/null 2>&1; then
            echo "  PASS: $test dry-run succeeded"
        else
            echo "  FAIL: $test dry-run failed"
        fi
    fi
done

echo ""
echo "========================================"
echo "  All tests complete"
echo "========================================"
