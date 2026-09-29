# RULES_GENERAL.md

# Language-agnostic rules. Apply to every file in this project.

## Project structure

- Frontend code goes in `frontend/src/`, backend code goes in `backend/app/`
- Never create a new top-level project directory for frontend or backend code

## Code quality

1. Write code for the next developer, not just the machine.
2. Name variables and functions for what they do, not how they do it.
3. No commented-out code. Use git history instead.
4. No TODO comments without a ticket/issue reference.
5. If you copy-pasted something, stop and extract it into a shared utility.

## SOLID at a glance

- Single Responsibility: one reason to change per module/class/function
- Open/Closed: open for extension, closed for modification
- Liskov Substitution: subtypes must behave like their base type
- Interface Segregation: small, focused interfaces over large general ones
- Dependency Inversion: depend on abstractions, inject dependencies

## DRY (Don't Repeat Yourself)

If the same logic appears twice → extract it.
If the same constant appears twice → name it once.
If the same validation appears twice → centralize it.

## KISS (Keep It Simple)

The simplest solution that correctly solves the problem is the right solution.
Never add abstraction layers that aren't justified by actual requirements.
Never optimize before profiling proves it's needed.

## File size limits

- 200 lines max per file (all languages)
- If a file needs more: it has more than one responsibility. Split it.

## Naming conventions

- Frontend (TS): PascalCase components, camelCase variables/functions, UPPER_SNAKE constants
- Backend (Python): snake_case everything, PascalCase classes, UPPER_SNAKE constants
- Files: kebab-case for frontend, snake_case for backend
- Database tables: snake_case plural (`product_items`, `user_sessions`)

## What never to do

- Never commit secrets, API keys, or credentials
- Never push directly to main/master
- Never skip error handling because "it won't happen"
- Never leave console.log / print() debug statements in committed code

## Behavioral Rules (read before every task)

- Never use the em dash (—). Use plain dash (-) instead
- When writing commit messages, NEVER auto-add your agent name as co-author
- Never manually modify CHANGELOG.md files or any files that are marked as auto-generated
- When writing or substantially editing long Markdown files, put each full sentence on its own line.
  Preserve normal Markdown structure, but avoid wrapping multiple full sentences onto one physical line
- When making technical decisions, do not give much weight to development cost.
  Instead, prefer quality, simplicity, robustness, scalability, and long-term maintainability
- When doing bug fixes, always start with reproducing the bug in an E2E setting as closely aligned with how an end user experiences it.
  This makes sure you find the real problem so your fix will actually solve it
- When end-to-end testing a product, be picky about the UI you see and be obsessed with pixel perfection.
  If something clearly looks off, even if it is not directly related to what you are doing, try to get it fixed along the way
- Apply that same high standard to engineering excellence: lint, test failures, and test flakiness.
  If you see one, even if it is not caused by what you are working on right now, still get it fixed

## Karpathy Behavioral Rules

### K1. Think Before Coding
Don't assume. Don't hide confusion. Surface tradeoffs.
Before implementing:
- State your assumptions explicitly. If uncertain, ask.
- If multiple interpretations exist, present them — don't pick silently.
- If a simpler approach exists, say so. Push back when warranted.
- If something is unclear, stop. Name what's confusing. Ask.

### K2. Simplicity First
Minimum code that solves the problem. Nothing speculative.
- No features beyond what was asked.
- No abstractions for single-use code.
- No "flexibility" or "configurability" that wasn't requested.
- No error handling for impossible scenarios.
- If you write 200 lines and it could be 50, rewrite it.
Self-check: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

### K3. Surgical Changes
Touch only what you must. Clean up only your own mess.
When editing existing code:
- Don't "improve" adjacent code, comments, or formatting.
- Don't refactor things that aren't broken.
- Match existing style, even if you'd do it differently.
- If you notice unrelated dead code, mention it — don't delete it.
When your changes create orphans:
- Remove imports/variables/functions that YOUR changes made unused.
- Don't remove pre-existing dead code unless asked.
Test: every changed line must trace directly to the user's request.

### K4. Goal-Driven Execution
Define success criteria. Loop until verified.
Transform every task into a verifiable goal before starting:
- "Add validation" → write tests for invalid inputs, then make them pass
- "Fix the bug" → write a test that reproduces it, then make it pass
- "Refactor X" → ensure tests pass before and after
For multi-step tasks, state a plan first:
  1. [Step] → verify: [check]
  2. [Step] → verify: [check]
  3. [Step] → verify: [check]
Strong success criteria = agent loops independently.
Weak criteria ("make it work") = constant clarification needed.
