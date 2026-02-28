#!/usr/bin/env bash
set -euox pipefail

/*
 * Configure MCP servers for Claude Code.
 *
 * Example:
 *   ./setup_mcp.sh
 *
 * Environment:
 *   PATH — must include claude binary
 */

export PATH="/root/.claude/local/bin:/root/.local/bin:$PATH"

claude mcp add --scope user context7 -- npx -y @upstash/context7-mcp@latest
claude mcp add --scope user mcp-atlassian -- uvx mcp-atlassian
claude mcp add --scope user ElevenLabs -- uvx elevenlabs-mcp
