#!/usr/bin/env bash
# Install GitHub CLI from precompiled binaries
set -eu
. /etc/tool-versions

curl -fsSL "https://github.com/cli/cli/releases/download/v${GH_CLI_VERSION}/gh_${GH_CLI_VERSION}_linux_amd64.tar.gz" \
  | tar -xz -C /usr/local --strip-components=1
