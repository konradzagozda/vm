#!/usr/bin/env bash
set -euox pipefail

# Install OpenTofu via the official standalone installer.
#
# Example:
#   ./install_opentofu.sh
#
# Environment:
#   OPENTOFU_VERSION — required, from /etc/tool-versions.env

. /etc/tool-versions.env

curl --proto '=https' --tlsv1.2 -fsSL https://get.opentofu.org/install-opentofu.sh \
  | sh -s -- --install-method standalone --opentofu-version "$OPENTOFU_VERSION"
