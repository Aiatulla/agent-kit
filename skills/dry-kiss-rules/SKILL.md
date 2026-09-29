---
name: dry-kiss-rules
description: >
  Generates and maintains a universal AI-agent rules file (.agents/rules/CODE_RULES.md)
  enforcing DRY, KISS, YAGNI, single-responsibility, clean architecture, and senior-engineer
  best practices for React + Next.js frontend and Python (FastAPI/Django) backend projects.
  Trigger this skill whenever the user asks to: create or update project rules, set up coding
  standards, configure AI agent behavior, write a CLAUDE.md or .cursorrules equivalent,
  enforce clean code standards, set up architecture guidelines, or says anything like
  "add rules for my project", "make agents follow best practices", "set up coding guidelines",
  "enforce DRY/KISS", or "update my rules file". Also trigger when the user wants to improve
  code quality, reduce technical debt, or establish team conventions. This skill outputs a
  single universal rules file readable by Claude, Cursor, Gemini, GPT, and any AI coding agent.
---

# DRY-KISS-RULES Skill

Generates a universal `.agents/rules/CODE_RULES.md` file that any AI coding agent can read and follow. The rules enforce pragmatic senior-engineer standards for React/Next.js + Python (FastAPI/Django) projects — without overengineering.

## Key Design Decisions (read before generating)

- **No forced full SOLID** — classes are used where they genuinely add value (service layer, data models, complex domain logic), not everywhere
- **Pragmatic 3-layer architecture** — only enforced when a feature has real complexity; simple CRUD can stay lean
- **YAGNI is a hard gate** — agents must flag AND refuse to build unnecessary abstractions
- **Dependency Injection (DI) is required** — always use constructor injection in Python services, FastAPI `Depends()`, and props/context in React to keep the codebase highly testable and decoupled.
- **Next.js performance** is a first-class concern (RSC, lazy loading, bundle size, caching)
- **Rules file is AI-agnostic** — plain Markdown, no tool-specific syntax

## Output Target

```
.agents/
  rules/
    CODE_RULES.md   ← the universal rules file
```

## What to Generate

Read `/home/claude/dry-kiss-rules/references/CODE_RULES_TEMPLATE.md` and use it as the base. Customize for the user's specific project if they provide details (stack versions, additional conventions, folder structure).

## Generation Steps

1. Check if `.agents/rules/CODE_RULES.md` already exists in the user's project
   - If yes: merge/update, don't overwrite blindly
   - If no: create from template
2. Ask if they have a specific folder structure to document (optional)
3. Generate the file
4. Tell the user to add this line to their `CLAUDE.md` (or equivalent):
   ```
   Always read and follow .agents/rules/CODE_RULES.md before writing any code.
   ```

## When User Asks to Enforce a Specific Rule

Apply the relevant section from CODE_RULES.md to the current task. Cite the rule being applied.

## Over-Engineering Detection (YAGNI Gate)

Before writing any code, mentally check:
- Am I creating an abstraction with only one current use case? → STOP, flag it
- Am I adding a design pattern "for future flexibility"? → STOP, flag it
- Is this class/layer/interface solving a real current problem? → Proceed only if yes

If flagged: tell the user *why* it's over-engineering and propose the simpler alternative. Do not build it until the user explicitly overrides with a reason.
