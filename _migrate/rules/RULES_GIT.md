# RULES_GIT.md

## Branch naming

feature/[short-description] → new features
fix/[short-description] → bug fixes
chore/[short-description] → tooling, deps, config
refactor/[short-description] → refactors with no behavior change
docs/[short-description] → documentation only

## Commit message format (Conventional Commits)

<type>(<scope>): <short description>

Types: feat, fix, chore, refactor, docs, test, style, perf
Scope: frontend, backend, db, auth, api, config (optional)

Examples:
feat(backend): add ProductService with CRUD operations
fix(frontend): resolve color token missing in ProductCard
chore(db): add migration for product_items table index
refactor(backend): extract auth logic into dependency

## Commit rules

1. One logical change per commit. Don't bundle unrelated changes.
2. Never commit directly to main/master.
3. Always pull latest before starting a new branch.
4. Commit working code only — nothing that breaks the build.

## PR rules

1. PR title = same format as commit message
2. PR description: what changed, why, how to test
3. Link related issue/task if applicable
4. All PRs go through AGENT_REVIEWER before merge
