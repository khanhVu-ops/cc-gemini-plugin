# Multi-Agent Delegation Rules: Claude Code + Gemini CLI (agy)

You have access to the subagent `gemini-agent` (via `cc-gemini-plugin`).
To optimize token usage, accelerate execution, and maintain high code quality, follow this workflow:

## 1. Task Complexity Scoring & Delegation Filter

Evaluate every incoming user request against this **4-Point Filter** before writing code:

| Evaluation Dimension | 🟢 Delegate to `gemini-agent` (Score: 1-2) | 🔴 Keep in Claude (Score: 3-5) |
| :--- | :--- | :--- |
| **1. Pattern / Precedent** | **Existing pattern exists:** Project already has similar files, tests, DTOs, or endpoints to follow. | **No precedent:** Requires novel system design, introducing new paradigms, or choosing frameworks. |
| **2. Scope of Impact** | **Isolated (1-3 files):** Changes are self-contained and do not risk breaking cross-module contracts. | **System-wide / Cross-cutting:** Modifies shared core libraries, DB schemas, or central pipelines. |
| **3. Ambiguity & Logic** | **Deterministic:** Explicit inputs and outputs, straightforward transformation or boilerplate. | **Ambiguous / High-reasoning:** Subtle race conditions, memory leaks, complex business rules. |
| **4. Security & Risk** | **Low-risk:** UI components, helpers, mock data, unit tests, documentation, linting. | **High-risk:** Authentication, authorization, token encryption, payment flows, secret handling. |

### 🟢 Concrete Gemini Delegations:
1. **Unit Tests & Test Fixtures:** Generating comprehensive unit/integration tests for existing functions and classes.
2. **Boilerplate & CRUD:** Creating standard DTOs, schemas, models, serializers, or repetitive CRUD handlers.
3. **Documentation & Typing:** Adding JSDoc, docstrings, README guides, or strict TypeScript/Swift types.
4. **Code Quality & Refactoring:** Fixing linter/compiler warnings, applying formatters, mechanical symbol renames, syntax upgrades.
5. **Large-Context Ingestion:** Scanning dozens of files or large logs to locate definitions, configs, or patterns.

### 🔴 Concrete Claude Handled Directly:
1. Architecture, state management strategy, database migrations.
2. Elusive bugs requiring cross-file hypothesis testing.
3. Security, crypto, authentication, and permission logic.
4. Interactive planning or resolving ambiguous user requirements.

## 2. Delegation Protocol
When delegating to `gemini-agent`:
- Provide target file paths, constraints, and reference patterns in the codebase.
- Instruct `gemini-agent` to edit files in-place and provide a structured summary of changes.

## 3. Mandatory Review Protocol
Immediately after `gemini-agent` completes:
1. Run `git status` and `git diff` to inspect every modified file.
2. Verify code correctness, edge cases, and compliance with project conventions.
3. Run the project's test suite / build / linter.
4. Present a concise review to the user before finalizing.
