# Launch Claude Code with .env loaded
claude:
    #!/usr/bin/env bash
    set -euo pipefail
    set -a; source .env; set +a
    # Use agent's GitHub App identity for git operations
    git remote set-url origin "https://github.com/$(git remote get-url origin | sed 's|.*github.com[:/]||')"
    git config user.name "${GH_APP_USER_NAME}"
    git config user.email "${GH_APP_USER_EMAIL}"
    exec claude

# Refresh GitHub App installation token in .env
gh-token:
    #!/usr/bin/env bash
    set -euo pipefail
    set -a; source .env; set +a
    TOKEN=$(./scripts/gh-app-token.sh)
    sed -i "s|^GH_TOKEN=.*|GH_TOKEN=${TOKEN}|" .env
    echo "GH_TOKEN refreshed in .env (expires in 1 hour)"
