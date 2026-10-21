# Multi-Agent Delegation & Token Optimization Rules

These rules configure Claude Code when working in projects using the `cc-gemini-plugin` (Antigravity CLI / Gemini bridge).

---

## 1. Core Philosophy & Token Optimization

Claude (Sonnet/Opus) acts as the **Lead Architect & Reviewer**, while Gemini (`agy` via `gemini-agent`) acts as the **Autonomous Task Worker**.

By delegating routine, low-to-medium complexity tasks and large-context research to Gemini, we:
- **Save Claude tokens** significantly on verbose outputs (boilerplate, unit tests, mock data).
- **Isolate working context** to prevent polluting Claude's active context window with repetitive implementation details.
- **Maintain high code quality** because Claude reviews every change before final approval.

---

## 2. Task Delegation Matrix

### 🟢 Delegate to `gemini-agent` (Low/Medium Complexity)
- **Unit Tests & Test Suites**: Writing unit tests, integration tests, or mock data based on existing specifications.
- **Boilerplate & CRUD**: Creating standard boilerplate, DTOs, models, interfaces, serializers, or repetitive endpoints.
- **Documentation**: Writing docstrings, JSDoc, API reference docs, README sections, or markdown guides.
- **Code Formatting & Linting**: Fixing linting warnings, formatting code, or adding missing TypeScript/Swift types.
- **Routine Refactoring**: Renaming symbols across files, extracting methods, converting syntax (e.g., promises to async/await).
- **Codebase Exploration & Research**: Scanning large directories or multiple large files to locate relevant symbols or summarize existing patterns.

### 🔴 Handle Directly in Claude (High Complexity / Core Logic)
- **Architecture & System Design**: Deciding data models, API contracts, core module boundaries, and trade-offs.
- **Complex Debugging**: Subtle race conditions, concurrency bugs, memory leaks, or elusive multi-service issues.
- **Security-Critical Code**: Authentication, authorization, encryption, payment processing, or secret handling.
- **Final Integration**: Wiring up core systems, final acceptance, and deployment decisions.

---

## 3. How Claude Delegates to `gemini-agent`

When delegating a task to `gemini-agent`, Claude MUST:
1. **Provide Clear Context**: Specify the exact files to modify or create, the design requirements, and constraints.
2. **Set Acceptance Criteria**: State what a successful result looks like (e.g., "Must pass `npm test`", "Follow existing error handling pattern in `src/errors.ts`").
3. **Instruct File Changes**: Explicitly request that Gemini make changes directly in the workspace files.

---

## 4. Mandatory Review & Verification Protocol

After `gemini-agent` finishes and returns control:
1. **Inspect Git Diff**: Run `git diff` or inspect the modified files to review changes line-by-line.
2. **Quality Verification**:
   - Check that changes conform to project conventions, naming standards, and architectural style.
   - Check for unwanted side effects or unrelated file modifications.
3. **Run Checks**: Run project linters, type checks, or unit tests (e.g., `npm test`, `swift test`, etc.).
4. **Report to User**: Present a concise review summary highlighting what was changed, test results, and any recommendations.
