#!/usr/bin/env bash
set -euo pipefail

# install-rules.sh: Appends Multi-Agent Delegation Rules to CLAUDE.md
# Usage:
#   bash scripts/install-rules.sh [--global | --local]

MODE="${1:---global}"
TARGET_FILE=""

if [ "$MODE" = "--global" ] || [ "$MODE" = "-g" ]; then
  CLAUDE_DIR="$HOME/.claude"
  mkdir -p "$CLAUDE_DIR"
  TARGET_FILE="$CLAUDE_DIR/CLAUDE.md"
  echo "Installing delegation rules globally to: $TARGET_FILE"
elif [ "$MODE" = "--local" ] || [ "$MODE" = "-l" ]; then
  TARGET_FILE="./CLAUDE.md"
  echo "Installing delegation rules to current directory: $TARGET_FILE"
else
  echo "Usage: $0 [--global | --local]"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
RULE_SOURCE="$SCRIPT_DIR/../rules/claude-delegation-rules.md"

if [ ! -f "$RULE_SOURCE" ]; then
  echo "Error: Rule source file not found at $RULE_SOURCE"
  exit 1
fi

MARKER="Multi-Agent Delegation Rules"

if [ -f "$TARGET_FILE" ] && grep -q "$MARKER" "$TARGET_FILE"; then
  echo "Notice: Rules already exist in $TARGET_FILE. No changes made."
  exit 0
fi

echo "" >> "$TARGET_FILE"
cat "$RULE_SOURCE" >> "$TARGET_FILE"
echo "Success: Delegation rules added to $TARGET_FILE"
