#!/usr/bin/env bash
set -euox pipefail

# Install oh-my-zsh (unattended).
#
# Example:
#   ./install_ohmyzsh.sh

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
