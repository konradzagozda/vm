# Load .env and refresh GitHub App token
_setup:
    #!/usr/bin/env bash
    set -euo pipefail
    set -a; source .env; set +a
    TOKEN=$(./scripts/gh-app-token.sh)
    sed -i "s|^GH_TOKEN=.*|GH_TOKEN=${TOKEN}|" .env

# Launch Claude Code with agent identity
claude: _setup
    #!/usr/bin/env bash
    set -euo pipefail
    set -a; source .env; set +a
    git remote set-url origin "https://github.com/$(git remote get-url origin | sed 's|.*github.com[:/]||')"
    git config user.name "${GH_APP_USER_NAME}"
    git config user.email "${GH_APP_USER_EMAIL}"
    exec claude
