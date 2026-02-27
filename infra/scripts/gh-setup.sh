#!/usr/bin/env bash
# Authenticate GitHub CLI using GitHub App credentials.
# Requires: GH_APP_ID, GH_APP_INSTALLATION_ID, GH_APP_PRIVATE_KEY_PATH
# Works with either `gh token` (gh extension) or `gh-token` (standalone binary).
set -euo pipefail

if command -v gh-token &>/dev/null; then
  token_cmd="gh-token"
elif gh token --help &>/dev/null; then
  token_cmd="gh token"
else
  echo "Error: neither gh-token binary nor gh token extension found" >&2
  exit 1
fi

$token_cmd generate \
  --app-id "$GH_APP_ID" \
  --installation-id "$GH_APP_INSTALLATION_ID" \
  --key "$GH_APP_PRIVATE_KEY_PATH" \
  | jq -r '.token' \
  | gh auth login --with-token
