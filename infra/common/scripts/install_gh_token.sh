#!/usr/bin/env bash
set -euox pipefail

/*
 * Install gh-token standalone binary.
 *
 * Example:
 *   ./install_gh_token.sh
 *
 * Environment:
 *   GH_TOKEN_VERSION — required, from /etc/tool-versions.env
 */

. /etc/tool-versions.env

curl -fsSL "https://github.com/Link-/gh-token/releases/download/v${GH_TOKEN_VERSION}/linux-amd64" \
  -o /usr/local/bin/gh-token
chmod +x /usr/local/bin/gh-token
