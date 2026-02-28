---
paths:
  - "**/*.sh"
---

## Shebang

Every script starts with `#!/usr/bin/env bash` and `set -eu`.

## Header

Every script has a top-level block comment with, in this order:

1. Purpose — what the script does
2. Example — at least one invocation example
3. Usage — full usage / flags / environment variables

```bash
#!/usr/bin/env bash
set -eu

/*
 * Install GitHub CLI from precompiled binaries.
 *
 * Example:
 *   ./install-gh-cli.sh
 *
 * Environment:
 *   GH_CLI_VERSION — required, read from /etc/tool-versions.env
 */
```

## Environment variables

Prefer passing information via environment variables over positional arguments.
