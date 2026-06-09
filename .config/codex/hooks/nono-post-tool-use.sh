#!/usr/bin/env bash
set -euo pipefail

if [ "${PITCH_MANAGED_AGENT:-}" = "1" ]; then
  exit 0
fi

exec "$HOME/.config/nono/packages/always-further/codex/bin/nono-hook.sh"
