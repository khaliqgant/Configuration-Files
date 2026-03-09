# OpenClaw (Dockerized)

Sandboxed [OpenClaw](https://docs.openclaw.ai/) gateway — AI coding agent accessible via browser UI or messaging channels.

## Prerequisites

- Docker installed
- Dropbox synced (config lives in `~/Dropbox/Khaliq Gant/KJG/Creds/`)
- Shell secrets sourced via `~/.secrets.zsh`

## Setup (new machine)

### 1. Symlink secrets

```bash
ln -sf ~/Dropbox/Khaliq\ Gant/KJG/Creds/.secrets.zsh ~/.secrets.zsh
```

### 2. Build the image

```bash
docker build -t openclaw ~/Configuration-Files/docker/openclaw
```

### 3. Copy Dropbox config into the volume, then run

The Dropbox config sets `bind: loopback` which blocks access from outside the container.
Do **not** mount it as `:ro` — the entrypoint needs to patch `bind` to `lan` so Docker port mapping works.

```bash
docker volume create openclaw-data
docker run --rm \
  -v "$HOME/Dropbox/Khaliq Gant/KJG/Creds/openclaw.json:/src/openclaw.json:ro" \
  -v openclaw-data:/dest \
  alpine cp /src/openclaw.json /dest/openclaw.json

docker run -d --name openclaw \
  -p 18789:18789 -p 18791:18791 \
  -e ANTHROPIC_API_KEY="$(grep ANTHROPIC_API_KEY ~/.secrets.zsh | cut -d'"' -f2)" \
  -e ELEVENLABS_API_KEY="$(grep ELEVENLABS_API_KEY ~/.secrets.zsh | cut -d'"' -f2)" \
  -e OPENAI_API_KEY="$(grep OPENAI_API_KEY ~/.secrets.zsh | cut -d'"' -f2)" \
  -v openclaw-data:/root/.openclaw \
  --restart unless-stopped \
  openclaw
```

### 4. Open the UI

http://127.0.0.1:18789/

Get the auth token if prompted:

```bash
docker exec openclaw node -e "const c=JSON.parse(require('fs').readFileSync('/root/.openclaw/openclaw.json','utf8'));console.log(c.gateway?.auth?.token)"
```

## What works everywhere

- Telegram messaging + voice
- TTS (ElevenLabs)
- Email (Gmail via gws)
- GitHub (gh CLI)
- Coding agents (Claude Code, Codex)
- Multi-agent (main, coder, writer, research)
- Web search (Perplexity)
- Summarize URLs/YouTube

## What's Mac mini only

- Peekaboo / XDeck (screen capture)
- Apple Reminders / Notes
- 1Password desktop integration
- XDeck tweet digest cron

## Subsequent runs

Config persists in the volume + Dropbox — just start:

```bash
docker start openclaw
```

## Teardown

```bash
docker rm -f openclaw              # stop and remove container
docker volume rm openclaw-data     # delete all config and data
```
