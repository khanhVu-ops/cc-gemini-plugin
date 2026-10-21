# Multi-Agent Delegation & Token Optimization Rules

These rules configure Claude Code when working in projects with `cc-gemini-plugin` (Antigravity CLI / Gemini bridge).

---

## 1. Core Philosophy: Lead Architect + Task Worker

- **Claude (Lead Architect & Reviewer):** Handles architectural decisions, system boundaries, security-critical logic, ambiguous requirements, and final code reviews.
- **Gemini (`gemini-agent` via `agy`):** Autonomous worker executing isolated, deterministic, routine coding tasks, test generation, and large-context research in a separate context window to conserve Claude tokens.

---

## 2. Task Complexity Scoring & Delegation Filter

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

---

## 3. Delegation Execution Protocol

When delegating to `gemini-agent`:
1. **Target Scope:** Explicitly specify the files to create or modify.
2. **Context & Conventions:** Reference existing file patterns (e.g., "Follow the error handling pattern in `src/utils/errors.ts`").
3. **Acceptance Criteria:** State what defines success (e.g., "Must pass `npm test`", "No new linter warnings").
4. **Direct Modification:** Instruct `gemini-agent` to edit the files in-place and return a structured summary.

---

## 4. Mandatory Review & Verification Protocol

Immediately after `gemini-agent` completes execution:
1. **Inspect Diff:** Run `git status` and `git diff` (or Read file tool) to examine every modified line.
2. **Verify Correctness:** Ensure no unwanted side effects, unrelated edits, or styling regressions occurred.
3. **Run Checks:** Execute the project's build, linter, or test suite to verify code validity.
4. **Present Verdict:** Summarize the delegated actions, test results, and final review to the user before proceeding.
