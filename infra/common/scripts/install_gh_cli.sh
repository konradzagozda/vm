#!/usr/bin/env bash
set -euox pipefail

/*
 * Install GitHub CLI from precompiled binaries.
 *
 * Example:
 *   ./install_gh_cli.sh
 *
 * Environment:
 *   GH_CLI_VERSION — required, from /etc/tool-versions.env
 */

. /etc/tool-versions.env

curl -fsSL "https://github.com/cli/cli/releases/download/v${GH_CLI_VERSION}/gh_${GH_CLI_VERSION}_linux_amd64.tar.gz" \
  | tar -xz -C /usr/local --strip-components=1
