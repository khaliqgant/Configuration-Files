#!/usr/bin/env bash

repos=$(<data/repos.txt)
sites=~/Sites

$dry mkdir -p "$sites"

while read -r line; do
    # handle "url dirname" format (e.g. "git@github.com:foo/bar.git my-dir")
    repo=$(echo "$line" | awk '{print $1}')
    dir=$(echo "$line" | awk '{print $2}')

    # derive directory name from repo url if not specified
    if [[ -z "$dir" ]]; then
        dir=$(basename "$repo" .git)
    fi

    # Support paths like "Projects/ai-hist" — resolve relative to $HOME
    if [[ "$dir" == */* ]]; then
        target="$HOME/$dir"
    else
        target="$sites/$dir"
    fi

    if [ -d "$target" ]; then
        echo "$dir already cloned, skipping"
    else
        $dry mkdir -p "$(dirname "$target")"
        $dry git clone "$repo" "$target"
    fi
done < data/repos.txt

# ─── ai-hist setup ──────────────────────────────────────────────────────────
echo "setting up ai-hist"
$dry mkdir -p "$HOME/.local/bin"
$dry ln -sf "$HOME/Projects/ai-hist/ai-hist" "$HOME/.local/bin/ai-hist"

# Install launchd plist for auto-sync every 60s
PLIST="$HOME/Library/LaunchAgents/com.ai-hist.sync.plist"
if [ ! -f "$PLIST" ]; then
    $dry mkdir -p "$HOME/Library/LaunchAgents"
    cat > "$PLIST" << EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>com.ai-hist.sync</string>
    <key>ProgramArguments</key>
    <array>
        <string>/usr/bin/python3</string>
        <string>${HOME}/.local/bin/ai-hist</string>
        <string>sync</string>
    </array>
    <key>StartInterval</key>
    <integer>60</integer>
    <key>RunAtLoad</key>
    <true/>
    <key>StandardOutPath</key>
    <string>/tmp/ai-hist-sync.log</string>
    <key>StandardErrorPath</key>
    <string>/tmp/ai-hist-sync.err</string>
</dict>
</plist>
EOF
    $dry launchctl load "$PLIST"
    echo "ai-hist launchd plist installed"
else
    echo "ai-hist launchd plist already exists, skipping"
fi
