#!/usr/bin/env bash
set -euox pipefail

# Install uv (Python package manager).
#
# Example:
#   ./install_uv.sh

curl -LsSf https://astral.sh/uv/install.sh | sh
