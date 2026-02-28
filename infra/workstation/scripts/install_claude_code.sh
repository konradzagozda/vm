#!/usr/bin/env bash
set -euox pipefail

/*
 * Install Claude Code CLI.
 *
 * Example:
 *   ./install_claude_code.sh
 */

curl -fsSL https://claude.ai/install.sh | bash
