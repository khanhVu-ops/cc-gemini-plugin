---
description: Delegate tasks through Antigravity CLI (agy) using its models, tools, and separate working context
allowed-tools: Bash, Glob, Read
argument-hint: "[options] <task>"
---

Read `${CLAUDE_PLUGIN_ROOT}/skills/gemini-integration/SKILL.md` and follow its
shared workflow for the request below, including any supplied bridge options.

User request:

$ARGUMENTS

---

### Post-Delegation Review Protocol:
After the delegate finishes:
1. Inspect modified files using `git status` and `git diff` (or Read tool).
2. Verify correctness and ensure no unintended changes occurred.
3. Run project build/test checks if applicable.
4. Provide a concise summary and review verdict to the user.
