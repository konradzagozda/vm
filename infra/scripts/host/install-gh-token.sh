#!/usr/bin/env bash
# Install gh-token standalone binary
set -eu
. /etc/tool-versions

curl -fsSL "https://github.com/Link-/gh-token/releases/download/v${GH_TOKEN_VERSION}/linux-amd64" \
  -o /usr/local/bin/gh-token
chmod +x /usr/local/bin/gh-token
