# Global agent rules

These rules apply in every project, for every tool.
Stack rules and project rules add to them; where a project rule is more specific, the project rule wins.

## Integrity

1. Never modify tests, expected outputs, snapshots, or fixtures to make checks pass.
   A failing test means the implementation is wrong until proven otherwise.
2. Never weaken a check: no `Any` or `as any`, `type: ignore`, `ts-ignore`, `noqa`, `eslint-disable`, skip or xfail, loosened assertions, or broad exception handling that swallows errors.
3. Never change a function's output, signature, or return type just to satisfy a check.
   Fix the logic that produces it.
4. Fix the root cause, not the symptom.
5. Stop rule: if the same check still fails after 3 genuine attempts, stop.
   Report the exact error, what you tried and why each attempt failed, your root-cause hypothesis, and what you need.
6. If you believe a test itself is wrong, do not edit it.
   Stop, explain why, and let the user decide.
7. When resolving merge or rebase conflicts, preserve the intent of both sides.
   Never take one side wholesale without explaining what the other side did and why it is safe to drop.
   Run `scripts/verify.sh full` after resolving.

## Think before coding

- State your assumptions explicitly.
  If uncertain, ask.
- If multiple interpretations exist, present them; do not pick one silently.
- If a simpler approach exists, say so, and push back when warranted.
- If something is unclear, stop, name what is confusing, and ask.
- Before creating a component, model, schema, type, or utility, check the project's inventory and the code for an existing one and reuse it.

## Design: quality and simplicity

Never choose a worse design to save effort, and never add complexity the requirements do not need.
When two designs are equally sound, pick the simpler one.
Development cost is not a reason to cut quality; speculative need is not a reason to add code.

- No features beyond what was asked.
- No abstractions for single-use code, and no flexibility or configuration that was not requested.
- No error handling for impossible scenarios, and never skip error handling for possible ones.
- Never optimize before profiling proves it is needed.
- If the same logic, constant, or validation appears twice, extract it once.
- One reason to change per module, class, or function; depend on abstractions and inject dependencies.
- Files should stay under about 200 lines; a longer file usually has more than one responsibility, so split it.
  Stack lint presets enforce this where the tooling supports it.
- Self-check: would a senior engineer call this overcomplicated? If yes, simplify.

## Surgical changes

Every changed line must trace directly to the task.
Why: diffs stay reviewable and every change stays traceable to the spec.

- Do not improve adjacent code, comments, or formatting, and do not refactor what is not broken.
- Match the existing style, even if you would do it differently.
- Remove imports, variables, and functions that your change made unused; leave pre-existing dead code alone.
- Unrelated problems you notice (lint, flaky tests, visual glitches, dead code) go into a list in your final report.
  Never fix them in the same change.

## Goal-driven execution

Turn every task into a verifiable goal before starting, then loop until it is verified.

- Add validation: write tests for invalid inputs, then make them pass.
- Fix a bug: first reproduce it the way an end user experiences it, as end-to-end as practical, then write a test that fails for that reason, then make it pass.
  Why: reproducing it first proves you found the real problem.
- Refactor: tests pass before and after.
- For multi-step tasks, state the plan first, with a verification check for each step.
- Run `scripts/verify.sh fast` after each step and `scripts/verify.sh full` before you report done, if the project has it.
- When testing a user interface end to end, look closely at what you see.
  Anything that looks off goes into your report, even if it is unrelated.

## Code quality

- Write code for the next developer, not just the machine.
- Name things for what they do, not how they do it.
- No commented-out code; git history keeps it.
- No TODO comments without an issue reference.
- No debug print or log statements in committed code.
- Never commit secrets, API keys, or credentials.

## Writing

- Never use the em dash character; use a plain dash or a colon.
- In long Markdown files you write or substantially edit, put each full sentence on its own line while keeping normal Markdown structure.
  Why: line-based diffs stay readable.
- Never manually edit CHANGELOG files or files marked as generated.

## Git

- Branches: `feature/`, `fix/`, `chore/`, `refactor/`, `docs/` followed by a short description.
- Commits follow Conventional Commits: `<type>(<scope>): <short description>`.
  Types: feat, fix, chore, refactor, docs, test, style, perf; scope is optional.
- One logical change per commit; do not bundle unrelated changes.
- Commit working code only; nothing that breaks the build.
- Never add an agent name as co-author in commit messages.
- Never commit or push directly to the main branch.
- Pull the latest main branch before starting a new branch.
- Pull request title uses the commit message format; the description says what changed, why, and how to test, and links the related issue if there is one.
- Every pull request gets a review from the reviewer agent before merge.
