#!/bin/bash
# Docker entrypoint: bootstrap config files into the mounted volume, then run hermes.
set -e

HERMES_HOME="/opt/data"
INSTALL_DIR="/opt/hermes"

# --- Privilege dropping via gosu ---
if [ "$(id -u)" = "0" ]; then
    if [ -n "$HERMES_UID" ] && [ "$HERMES_UID" != "$(id -u hermes)" ]; then
        echo "Changing hermes UID to $HERMES_UID"
        usermod -u "$HERMES_UID" hermes
    fi

    if [ -n "$HERMES_GID" ] && [ "$HERMES_GID" != "$(id -g hermes)" ]; then
        echo "Changing hermes GID to $HERMES_GID"
        groupmod -g "$HERMES_GID" hermes
    fi

    actual_hermes_uid=$(id -u hermes)
    if [ "$(stat -c %u "$HERMES_HOME" 2>/dev/null)" != "$actual_hermes_uid" ]; then
        echo "$HERMES_HOME is not owned by $actual_hermes_uid, fixing"
        chown -R hermes:hermes "$HERMES_HOME"
    fi

    echo "Dropping root privileges"
    exec gosu hermes "$0" "$@"
fi

# --- Running as hermes from here ---
source "${INSTALL_DIR}/.venv/bin/activate"

# Create essential directory structure.
mkdir -p "$HERMES_HOME"/{cron,sessions,logs,hooks,memories,skills,skins,plans,workspace,home}

# .env
if [ ! -f "$HERMES_HOME/.env" ]; then
    cp "$INSTALL_DIR/.env.example" "$HERMES_HOME/.env"
fi

# config.yaml
if [ ! -f "$HERMES_HOME/config.yaml" ]; then
    cp "$INSTALL_DIR/cli-config.yaml.example" "$HERMES_HOME/config.yaml"
fi

# SOUL.md — always sync from bundled version (persona is deployment-managed, not user-edited)
cp "$INSTALL_DIR/docker/SOUL.md" "$HERMES_HOME/SOUL.md"

# Apply HERMES_MODEL override — if set, always write it into config.yaml
if [ -n "$HERMES_MODEL" ] && [ -f "$HERMES_HOME/config.yaml" ]; then
    echo "Setting model to: $HERMES_MODEL"
    python3 - <<EOF
import yaml, sys
path = "$HERMES_HOME/config.yaml"
with open(path) as f:
    cfg = yaml.safe_load(f) or {}
cfg.setdefault("model", {})["default"] = "$HERMES_MODEL"
with open(path, "w") as f:
    yaml.dump(cfg, f, default_flow_style=False, allow_unicode=True)
EOF
fi

# Restore Google Workspace MCP credentials — decoded from Coolify env var into persistent volume.
# Runs on every start so a rotated token (updated GOOGLE_TOKEN_B64) is picked up on redeploy.
if [ -n "$GOOGLE_TOKEN_B64" ]; then
    mkdir -p "$HERMES_HOME/workspace_mcp_creds"
    echo "$GOOGLE_TOKEN_B64" | base64 -d > "$HERMES_HOME/workspace_mcp_creds/zurilabsafrica@gmail.com.json"
    chmod 600 "$HERMES_HOME/workspace_mcp_creds/zurilabsafrica@gmail.com.json"
    echo "Google Workspace MCP credentials restored."
fi

# Apply MCP server configuration — always sync from bundled mcp.yaml
if [ -f "$INSTALL_DIR/docker/mcp.yaml" ] && [ -f "$HERMES_HOME/config.yaml" ]; then
    echo "Applying MCP server configuration..."
    python3 "$INSTALL_DIR/docker/apply_mcp.py"
fi

# Sync bundled skills (manifest-based so user edits are preserved)
if [ -d "$INSTALL_DIR/skills" ]; then
    python3 "$INSTALL_DIR/tools/skills_sync.py"
fi

exec hermes "$@"
