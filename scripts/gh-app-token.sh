#!/usr/bin/env bash
# Generates a fresh GitHub App installation access token (valid 1 hour).
set -euo pipefail

: "${GH_APP_ID:?required}"
: "${GH_APP_INSTALLATION_ID:?required}"
: "${GH_APP_PRIVATE_KEY_PATH:?required}"

gh token generate \
  --key "${GH_APP_PRIVATE_KEY_PATH}" \
  --app-id "${GH_APP_ID}" \
  --installation-id "${GH_APP_INSTALLATION_ID}" \
  | jq -r '.token'
