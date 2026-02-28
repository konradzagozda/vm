#!/usr/bin/env bash
set -euox pipefail

/*
 * Configure zsh as default shell and set up environment.
 * Writes /etc/profile.d/vm-env.sh to load secrets and tool paths.
 *
 * Example:
 *   ./setup_shell.sh
 */

chsh -s /usr/bin/zsh root

cat > /etc/profile.d/vm-env.sh << 'EOF'
# Load environment variables from mounted secrets
set -a; source /root/secrets/.env; set +a

# Claude Code
export PATH="$HOME/.claude/local/bin:$PATH"

# uv (installed to ~/.local/bin)
export PATH="$HOME/.local/bin:$PATH"

# Fix GH_APP_PRIVATE_KEY_PATH for VM context
export GH_APP_PRIVATE_KEY_PATH="/root/secrets/gh_app_key.pem"
EOF

echo 'emulate sh -c "source /etc/profile"' >> /etc/zsh/zprofile
