#!/usr/bin/env python3
"""Logs every Bash tool invocation to .claude/log/commands.jsonl"""

import json
import os
import sys
from datetime import datetime, timezone
from pathlib import Path

log_dir = Path(os.environ["CLAUDE_PROJECT_DIR"]) / ".claude" / "log"

data = json.load(sys.stdin)
entry = {
    "timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"),
    "command": data.get("tool_input", {}).get("command", ""),
    "cwd": data.get("cwd", ""),
}

with open(log_dir / "commands.jsonl", "a") as f:
    f.write(json.dumps(entry) + "\n")
