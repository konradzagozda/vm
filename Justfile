set dotenv-load

# Refresh GitHub App installation token
gh-token:
    gh token generate \
      --app-id "$GH_APP_ID" \
      --installation-id "$GH_APP_INSTALLATION_ID" \
      --key "$GH_APP_PRIVATE_KEY_PATH" \
      | jq -r '.token' \
      | gh auth login --with-token

# Launch Claude Code with agent identity
claude: gh-token
    git remote set-url origin "https://github.com/$(git remote get-url origin | sed 's|.*github.com[:/]||')"
    exec claude
