#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

# Install packages from list
xargs -a "$SCRIPT_DIR/vm-packages.txt" apt-get install -y

# Install GitHub CLI
curl -fsSL https://cli.github.com/packages/githubcli-archive-keyring.gpg \
  | dd of=/usr/share/keyrings/githubcli-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" \
  | tee /etc/apt/sources.list.d/github-cli.list
apt-get update
apt-get install -y gh

# Install Claude Code
curl -fsSL https://claude.ai/install.sh | bash

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# Set zsh as default shell for root
chsh -s /usr/bin/zsh root

# Configure zsh profile
cat >> /root/.zshrc << 'ZSHRC'

# Load environment variables
set -a; source /root/.env; set +a

# Claude Code
export PATH="$HOME/.claude/local/bin:$PATH"

# Fix GH_APP_PRIVATE_KEY_PATH for VM context
export GH_APP_PRIVATE_KEY_PATH="/root/.keys/vm-claude-agent.pem"
ZSHRC
