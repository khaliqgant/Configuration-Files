#!/bin/sh

CONFIG_DIR="/root/.openclaw"
CONFIG_FILE="$CONFIG_DIR/openclaw.json"

mkdir -p "$CONFIG_DIR"

# Generate config if it doesn't exist
if [ ! -f "$CONFIG_FILE" ]; then
    openclaw setup --non-interactive 2>/dev/null || true
fi

# Apply Claude setup token if provided (one-time auth with Claude subscription)
if [ -n "$CLAUDE_SETUP_TOKEN" ]; then
    mkdir -p /root/.claude
    echo "$CLAUDE_SETUP_TOKEN" | claude setup-token --pipe 2>/dev/null || \
    claude setup-token "$CLAUDE_SETUP_TOKEN" 2>/dev/null || true
fi

# Patch config: set gateway.mode and bind for container networking
node -e "
const fs = require('fs');
const path = '/root/.openclaw/openclaw.json';
let cfg = {};
try { cfg = JSON.parse(fs.readFileSync(path, 'utf8')); } catch(e) {}

cfg.gateway = cfg.gateway || {};
cfg.gateway.mode = 'local';
cfg.gateway.bind = 'lan';

// Use env token if provided for gateway auth
if (process.env.OPENCLAW_GATEWAY_TOKEN) {
    cfg.gateway.auth = cfg.gateway.auth || {};
    cfg.gateway.auth.mode = 'token';
    cfg.gateway.auth.token = process.env.OPENCLAW_GATEWAY_TOKEN;
}

fs.writeFileSync(path, JSON.stringify(cfg, null, 2));
console.log('[entrypoint] Config ready');
"

# Fix any invalid keys
openclaw doctor --fix 2>/dev/null || true

exec openclaw gateway --port 18789 --allow-unconfigured
