#!/usr/bin/env bash
# Install OpenTofu via the official standalone installer
set -eu
. /etc/tool-versions.env

curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh \
  | sh -s -- --install-method standalone --opentofu-version "$OPENTOFU_VERSION"
