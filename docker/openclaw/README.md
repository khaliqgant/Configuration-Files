# OpenClaw (Dockerized)

Sandboxed [OpenClaw](https://docs.openclaw.ai/) gateway — AI coding agent accessible via browser UI or messaging channels.

## Setup

### 1. Build the image

```bash
docker build -t openclaw ~/Configuration-Files/docker/openclaw
```

### 2. Generate a Claude setup token

```bash
claude setup-token
```

Copy the output token.

### 3. First run (with setup token)

```bash
docker run -d --name openclaw \
  -p 18789:18789 -p 18791:18791 \
  -e CLAUDE_SETUP_TOKEN="paste-token-here" \
  -v openclaw-data:/root/.openclaw \
  --restart unless-stopped \
  openclaw
```

### 4. Open the UI

http://127.0.0.1:18789/

Get the auth token if prompted:

```bash
docker exec openclaw node -e "const c=JSON.parse(require('fs').readFileSync('/root/.openclaw/openclaw.json','utf8'));console.log(c.gateway.auth.token)"
```

## Subsequent runs

Credentials persist in the volume — no setup token needed:

```bash
docker run -d --name openclaw \
  -p 18789:18789 -p 18791:18791 \
  -v openclaw-data:/root/.openclaw \
  --restart unless-stopped \
  openclaw
```

## Using an API key instead

If you prefer using an API key over a Claude subscription:

```bash
docker run -d --name openclaw \
  -p 18789:18789 -p 18791:18791 \
  -e ANTHROPIC_API_KEY="sk-ant-..." \
  -v openclaw-data:/root/.openclaw \
  --restart unless-stopped \
  openclaw
```

## Connecting messaging channels (optional)

```bash
docker exec -it openclaw openclaw channels login
```

## Teardown

```bash
docker rm -f openclaw              # stop and remove container
docker volume rm openclaw-data     # delete all config and data
```
