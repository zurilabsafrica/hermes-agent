---
name: zuri-engineering
description: Engineering context for Zuri Labs Africa — project tech stacks, deployment status, infrastructure, and procedures. Updated 2026-05-19.
version: 2.0.0
author: Zuri Labs Africa
metadata:
  hermes:
    tags: [Zuri-Labs, Engineering, Deployments, Coolify, Laravel, React, GlitchTip]
---

# Zuri Labs Engineering (May 2026)

## Infrastructure

- **Hosting**: Coolify (self-managed, Contabo VPS)
- **Error tracking**: GlitchTip (self-hosted on Coolify) — replaces Sentry
- **Automation**: n8n (self-hosted on Coolify — running healthy)
- **GitHub org**: zurilabsafrica
- **Proxy**: Traefik v3.6
- **DNS**: Cloudflare

## Active Projects

### Sosio Fruits & Vegetables (URGENT — deadline 2026-05-22)
- **Client**: Sosio Fruits and Vegetables (sosiofruitsandvegetables.com)
- **Frontend**: Next.js 15 App Router + TanStack Query + Tailwind — repo: zurilabsafrica/SosioFrontend
- **Backend**: Laravel 12 REST API + MySQL + Sanctum — repo: zurilabsafrica/SosioBackend
- **CMS**: Sanity (blog + content)
- **Deployment**: Coolify (Contabo VPS)
- **Status**: Active — both repos last pushed 2026-05-17. SEO 100/100 achieved. Performance optimization pending.
- **Next**: Complete and deliver by 2026-05-22.

### Enara (Healthcare Platform)
- **Client**: Sarah Njoka
- **Frontend**: React — repo: zurilabsafrica/EnaraFrontend (last push 2026-05-09)
- **Backend**: Laravel + Reverb (WebSockets) — repo: zurilabsafrica/EnaraBackend (last push 2026-05-08)
- **Deployment**: Coolify — enara-backend (healthy), enara-frontend (healthy), enara-worker (healthy), enara-reverb (running:unknown)
- **Status**: Module 1 complete (delivered 2026-03-27). Module 2 in progress — target 2026-06-09.
- **Stack**: Laravel + React. Real-time via Reverb. Queue worker via Horizon.

### BloomSenses — Adult Wellness Ecommerce (begins after Sosio)
- **Deadline**: 2026-07-15
- **Frontend**: React 18 + TypeScript + Vite + Tailwind + shadcn-ui — repo: zurilabsafrica/bloomsenses
- **Backend**: Laravel 13 REST API + PostgreSQL + Redis
- **Payments**: Paystack (card + M-Pesa)
- **Deployment**: Coolify
- **Status**: Planned — begins immediately after Sosio delivery.
- **Note**: Adult wellness ecommerce. 2000+ product catalog, variant support. Privacy-first checkout.

### ZuriPOS (SaaS POS)
- **Repo**: zurilabsafrica/zuri_pos (last push 2026-04-26)
- **Stack**: Laravel 10 + Vue.js 3 + MySQL — Docker (PHP 8.3-FPM + Nginx + Supervisor)
- **Deployment**: Coolify — pos.zurilabsafrica.com (running: healthy)
- **Error tracking**: GlitchTip
- **Status**: Live with Nova Mattresses Ltd. v5.4 stability sprint done (8 issues triaged, 7 fixed).

### ZuriClipper (Internal Tool)
- **Repo**: mwangiismuthui/ZuriVideoClipper
- **Stack**: FastAPI (Python) + React/TypeScript (Vite) + FFmpeg + Whisper + OpenRouter/Ollama/Claude
- **Status**: Phases 1-3 complete. End-to-end testing in progress.
- **Purpose**: AI YouTube clip extractor — vertical 9:16 output for Reels/TikTok/Shorts.

### CampaignIQ (AI Political Intelligence)
- **Repo**: mwangiismuthui/CampaignIQ (last push 2026-04-22)
- **Status**: Post-MVP. Grant deadline was 2026-04-30. Pilot client outreach phase.
- **Target**: Kenya 2027 election cycle.
- **AI**: has_ai true — models TBD.

### ZuriFilm (AI Movie Generator)
- **Status**: Planned — no repo yet.
- **AI stack**: Kling (video), ElevenLabs (voiceover), Suno (music), Flux/DALL-E (images)
- **Phase 1**: Internal tool. Phase 2: SaaS for indie filmmakers.
- **Input**: PDF, Fountain, or plain text movie script.

### BriefHQ (AI SaaS)
- **Status**: Not started — blocked by Enara Module 2 bandwidth.
- **Target**: 2026-06-30 beta.
- **Concept**: AI executive assistant SaaS for African startup founders.

### PayLink (OSS Contribution)
- **Fork**: zurilabsafrica/Payment_MCP_Servers
- **Upstream**: paylinkmcp/paylink
- **Status**: Active contributor. M-Pesa MCP server production-ready.
- **Next**: Airtel Money server. Sign CLA at cla-assistant.io before PRs.
- **Stack**: Python + Starlette + MCP + Docker.

### Hermes Agent (this system)
- **Repo**: zurilabsafrica/hermes-agent
- **Deployment**: Coolify — hermes.zurilabsafrica.com
- **Model**: claude-sonnet-4-6 via OpenRouter

### Other Live Infrastructure
- **Zuri Labs Website**: zurilabsafrica/Zuri-Labs — Coolify — zurilabsafrica.com
- **Sosio**: Coolify — sosio-backend + sosio-frontend (running:unknown — in development)
- **n8n**: Coolify — n8n.zurilabsafrica.com (running: healthy)
- **GlitchTip**: Coolify — self-hosted error tracking

## Standard Procedures

### Deploy a change
1. Push to `main` branch on GitHub
2. Coolify auto-deploys via webhook
3. Check deployment logs in Coolify dashboard

### Investigate a production error
1. Check GlitchTip (not Sentry) for error tracking
2. Check Coolify application logs for the affected service
3. Check env vars in Coolify — common cause of restarts

### Architecture decisions
Log to `decisions/log.md` in the PA repo.
Format: `[YYYY-MM-DD] DECISION: ... | REASONING: ... | CONTEXT: ...`
