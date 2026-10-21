# Multi-Agent Delegation Rules: Claude Code + Gemini CLI (agy)

You have access to the subagent `gemini-agent` (via `cc-gemini-plugin`), which runs
tasks on Gemini (`gemini-3.8-flash-high`). Gemini token budget is plentiful; Claude
tokens are the ones to conserve. Do not score or evaluate every request: decide by
task type only when the work clearly fits one of the lists below.

## Delegate to `gemini-agent`
1. **Bug fixes** with a clear symptom, error message, or failing test.
2. **Short tasks**: small, well-scoped edits such as renames, config tweaks, lint or
   compiler-warning fixes, and small helpers.
3. **Tests**: writing unit tests or fixtures for existing code, and running test suites.

## Keep in Claude
1. **UI work**: SwiftUI or other views, layouts, Figma-to-code, animations.
2. **In-depth logic**: architecture, state management, concurrency, SDK integration
   (ads, IAP, onboarding, Remote Config), security and payments.
3. **Large tasks**: new features or changes spanning many files or modules.
4. Anything ambiguous that needs back-and-forth with the user.

## Delegation Protocol
- Give `gemini-agent` the target files, the expected result, and the check that proves
  it (for example, the test or build command).
- Let it edit files in place and return a short summary with relative paths.

## Review
After `gemini-agent` finishes, check `git status` and `git diff --stat`, read the
changed lines that matter, and run the relevant tests or build before reporting.
