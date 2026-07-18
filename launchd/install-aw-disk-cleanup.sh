#!/usr/bin/env bash
# Installs the daily aw-disk-cleanup LaunchAgent on a macOS box.
# Idempotent: safe to re-run (reloads). Portable: plist is generated from $HOME.
# Usage:  bash launchd/install-aw-disk-cleanup.sh
set -euo pipefail

SRC_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LABEL="com.khaliqgant.aw-disk-cleanup"
BIN="$HOME/.local/bin/aw-disk-cleanup.sh"
PLIST="$HOME/Library/LaunchAgents/$LABEL.plist"
LOG="$HOME/Library/Logs/aw-disk-cleanup.log"
HOUR=13
MINUTE=0

mkdir -p "$HOME/.local/bin" "$HOME/Library/LaunchAgents" "$HOME/Library/Logs"
install -m 0755 "$SRC_DIR/aw-disk-cleanup.sh" "$BIN"

cat > "$PLIST" <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>$LABEL</string>
    <key>ProgramArguments</key>
    <array>
        <string>/bin/bash</string>
        <string>$BIN</string>
    </array>
    <key>StartCalendarInterval</key>
    <dict>
        <key>Hour</key>
        <integer>$HOUR</integer>
        <key>Minute</key>
        <integer>$MINUTE</integer>
    </dict>
    <key>RunAtLoad</key>
    <false/>
    <key>StandardOutPath</key>
    <string>$LOG</string>
    <key>StandardErrorPath</key>
    <string>$LOG</string>
</dict>
</plist>
PLIST

launchctl bootout "gui/$(id -u)/$LABEL" 2>/dev/null || true
launchctl bootstrap "gui/$(id -u)" "$PLIST"

echo "Installed $LABEL on $(hostname -s) — daily $(printf '%02d:%02d' "$HOUR" "$MINUTE")"
echo "  script: $BIN"
echo "  plist:  $PLIST"
echo "  log:    $LOG"
launchctl list | grep "$LABEL" || echo "  WARNING: not showing in launchctl list"
