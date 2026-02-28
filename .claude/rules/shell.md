---
paths:
  - "**/*.sh"
---

Every script starts with `#!/usr/bin/env bash` and `set -euo pipefail -x`.

Prefer passing information via environment variables over positional arguments.

## Header

Every script has a top-level block comment with, in this order:

1. Purpose — what the script does
2. Example — exactly one invocation example; more examples beneath Usage
3. Environment — required and optional environment variables
4. Usage — full usage / flags

```bash
#!/usr/bin/env bash
set -euo pipefail -x

/*
 * Install GitHub CLI from precompiled binaries.
 *
 * Example:
 *   ./install-gh-cli.sh
 *
 * Environment:
 *   GH_CLI_VERSION — required, read from /etc/tool-versions.env
 *
 * Usage:
 *   ./install-gh-cli.sh
 */
```
