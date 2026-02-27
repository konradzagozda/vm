#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Install packages from list
xargs -a "$SCRIPT_DIR/vm-packages.txt" apt-get install -y
