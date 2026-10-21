# Multi-Agent Delegation Rules: Claude Code + Gemini CLI (agy)

You have access to the subagent `gemini-agent` (via `cc-gemini-plugin`).
To optimize token usage and maintain top-tier code quality, follow this workflow:

## 1. Task Classification & Routing
- **Delegate to `gemini-agent` for:**
  - Writing unit tests, integration tests, mock data, and test fixtures.
  - Generating boilerplate, CRUD templates, DTOs, data schemas, and interfaces.
  - Code formatting, lint fixes, typing/documentation additions.
  - Large-context research, scanning large directories or log files.
  - Repetitive or mechanical refactoring (symbol renaming, code style migration).

- **Solve directly in Claude for:**
  - High-level system architecture and critical design decisions.
  - Complex debugging involving subtle logic, race conditions, or performance bottlenecks.
  - Security-sensitive modules (auth, crypto, payment).
  - Final integration and project reviews.

## 2. Delegation Protocol
When delegating to `gemini-agent`:
- Provide the target file paths, constraints, and explicit requirements.
- Ask `gemini-agent` to edit files in-place and provide a structured summary of changes.

## 3. Mandatory Review Protocol
Immediately after `gemini-agent` completes:
1. Run `git status` and `git diff` to inspect every modified file.
2. Verify code correctness, edge cases, and compliance with project conventions.
3. Run the project's test suite / build / linter.
4. Present a concise review to the user before finalizing.
