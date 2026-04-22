---
name: zuri-engineering
description: Engineering context for Zuri Labs Africa — project tech stacks, deployment status, infrastructure, and standard procedures for David Mwangi's assistant.
version: 1.0.0
author: Zuri Labs Africa
metadata:
  hermes:
    tags: [Zuri-Labs, Engineering, Deployments, Coolify, Laravel, React]
---

# Zuri Labs Engineering

## Projects and Tech Stacks

### Enara (Social / Community Platform)
- **Frontend:** React (repo: zurilabsafrica/EnaraFrontend)
- **Backend:** Laravel (repo: zurilabsafrica/EnaraBackend)
- **Deployment:** Coolify
  - `enara-backend` → https://api.enara.club (running)
  - `enara-frontend` → https://enara.club (running)
  - `enara-reverb` (WebSockets) → https://ws.enara.club (STATUS: restarting — needs fix)
  - `enara-worker` (Queue worker) → running
- **Status:** Module 1 complete. Module 2 begins on KES 30K deposit from Sarah Njoka.
- **Known issue:** `enara-reverb` is restarting. Investigate WebSocket/Reverb config. Check APP_KEY and REVERB_* env vars in Coolify.

### ZuriPOS (Point of Sale SaaS)
- **Repo:** zurilabsafrica/zuri_pos
- **Deployment:** Coolify → https://pos.zurilabsafrica.com (running: healthy)
- **Status:** Live with Nova Mattresses Ltd. Marketing phase.

### BriefHQ
- **Status:** Not started. Build begins after Enara M2 deposit received.
- **Concept:** AI executive assistant SaaS for African startup founders.
- **Target:** 6-week build, Q2 2026 beta launch.

### CampaignIQ
- **Status:** MVP built, pre-launch.
- **Concept:** AI political campaign intelligence tool. Kenya 2027 election cycle.
- **Next:** Grant proposal by 2026-04-30 (NDI/USAID or impact investors).

### ZuriClipper
- **Status:** Active development. Internal tool.
- **Concept:** AI YouTube clip extractor — outputs vertical 9:16 for Reels/TikTok/Shorts.

### Zuri Labs Website
- **Repo:** zurilabsafrica/Zuri-Labs
- **Deployment:** Coolify → https://zurilabsafrica.com (running)

### Hermes Agent (this system)
- **Repo:** zurilabsafrica/hermes-agent
- **Deployment:** Coolify → https://hermes.zurilabsafrica.com
- **Model:** via OpenRouter

### PayLink (OSS Contribution)
- **Upstream:** paylinkmcp/paylink
- **Fork:** zurilabsafrica/Payment_MCP_Servers
- **Status:** Active contributor. M-Pesa MCP server is production-ready.
- **Next:** Airtel Money server. Sign CLA at cla-assistant.io/paylinkmcp/paylink before PRs.
- **Stack:** Python, uv/uvicorn, Starlette, MCP, Docker.

## Infrastructure

- **Hosting:** Coolify on self-managed VPS (173.249.49.60)
- **Proxy:** Traefik v3.6
- **n8n:** Running on Coolify (healthy)
- **GitHub org:** zurilabsafrica
- **Freelancers:** Fredrick Mwaura handles Laravel/React implementation tasks

## Standard Procedures

### Deploy a change
1. Push to `main` branch on GitHub
2. Coolify auto-deploys via webhook
3. Monitor logs in Coolify dashboard

### Investigate a production error
1. Check Sentry for error tracking
2. Check Coolify application logs
3. For enara-reverb: check WebSocket config and env vars

### Fix enara-reverb (restarting)
```
Likely causes:
- REVERB_APP_ID, REVERB_APP_KEY, REVERB_APP_SECRET not set
- Port 8080 conflict
- APP_KEY mismatch between backend and reverb service
Check Coolify env vars for enara-backend and enara-reverb.
```

### Architecture decisions
All meaningful decisions → log to `decisions/log.md` in the PA repo.
Format: `[YYYY-MM-DD] DECISION: ... | REASONING: ... | CONTEXT: ...`
