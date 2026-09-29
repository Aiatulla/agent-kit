---
name: commiter
description: >
  Automatically splits all current unstaged/staged git changes into small, meaningful,
  logically grouped micro-commits using Conventional Commits format — and executes them.
  ALWAYS use this skill when the user says anything like: "make commits", "commit my changes",
  "split into commits", "micro commits", "commit everything", "do the commits", "commiter",
  "run commiter", or any variation of wanting git commits made from current changes.
  This skill runs fully autonomously: it reads the git diff, groups changes by logical intent,
  plans the commit sequence, shows the plan, then executes each commit automatically
  without the user needing to do anything manually.
---

# Commiter Skill

Reads all current git changes, groups them by logical intent, and executes micro-commits automatically — one per logical unit of work.

## Step-by-Step Execution

### Step 1 — Discover all changes

Run these commands to get full picture of what changed:

```bash
git status --short                    # overview of changed files
git diff --stat                       # unstaged changes summary
git diff --cached --stat              # staged changes summary  
git diff HEAD --stat                  # all changes vs last commit
```

If nothing is staged AND nothing is unstaged → tell user there's nothing to commit and stop.

If there are untracked files that seem intentional (new components, new pages, new utils) → include them. If they look like build artifacts or env files → skip them.

### Step 2 — Read the actual diffs

Read diffs to understand *what* changed, not just *which files*:

```bash
git diff HEAD -- <file>               # what changed in each file
git diff HEAD --name-only             # just the file list
```

For large diffs (>300 lines total), read file-by-file focusing on:
- What was added / removed / renamed
- What the change *does*, not just what lines changed

Also check if `.agents/rules/CODE_RULES.md` exists — if so read it for project conventions.

### Step 3 — Group changes into logical commits

This is the most important step. Group files by **logical intent**, not by file type or folder.

**Grouping rules (in priority order):**

1. **Feature grouping** — files that together implement one feature belong in one commit
   - Example: `UserCard.tsx` + `useUser.ts` + `user.service.ts` + `user.types.ts` → one `feat(user)` commit

2. **Refactor grouping** — files changed for the same refactor reason
   - Example: renamed prop across 4 components → one `refactor(components)` commit

3. **Fix grouping** — files changed to fix the same bug
   - Example: `auth.service.ts` + `auth.middleware.ts` → one `fix(auth)` commit

4. **Config/tooling grouping** — config files changed together
   - Example: `tailwind.config.ts` + `globals.css` + `theme.ts` → one `chore(config)` commit

5. **Style/UI grouping** — visual-only changes across multiple components
   - Example: spacing, color, typography tweaks → one `style(ui)` commit

6. **Test grouping** — test files for the same domain
   - Example: `user.test.ts` + `auth.test.ts` → one `test` commit, or split by domain

7. **Dependency grouping** — `package.json` + `package-lock.json`/`yarn.lock` always together
   - → `chore(deps): add/update/remove <package-name>`

8. **Docs grouping** — README, comments, documentation files
   - → `docs: update ...`

**Anti-patterns — never do these:**
- ❌ One commit per file (too granular, defeats the purpose)
- ❌ One giant commit for everything (defeats the purpose)
- ❌ Mixing unrelated changes in one commit (e.g., bug fix + new feature)
- ❌ Separating files that only make sense together (e.g., component + its hook)

**Commit size target:** 1–6 files per commit is healthy. 7+ files in one commit is a smell — consider splitting further.

### Step 4 — Build the commit plan

Before executing, build a structured plan:

```
COMMIT PLAN
───────────────────────────────────────────
Commit 1/4  feat(auth): add JWT refresh token flow
  → src/services/auth.service.ts
  → src/hooks/useAuth.ts
  → src/types/auth.types.ts

Commit 2/4  fix(user-profile): correct avatar upload size validation  
  → src/components/UserProfile/AvatarUpload.tsx
  → src/utils/file-validators.ts

Commit 3/4  style(hero): update hero section colors and spacing
  → src/components/Hero/HeroMarquee.tsx
  → src/styles/hero.css

Commit 4/4  chore(deps): add framer-motion, remove unused lodash
  → package.json
  → yarn.lock
───────────────────────────────────────────
Total: 4 commits across 9 files
```

Show this plan to the user. Then immediately proceed to execute — do NOT wait for approval unless the user has previously said they want to review first.

### Step 5 — Execute commits

For each commit in the plan, in order:

```bash
# Stage only the specific files for this commit
git add <file1> <file2> <file3>

# Commit with the planned message
git commit -m "<type>(<scope>): <description>"
```

**Important rules during execution:**
- Stage files **individually per commit** — never `git add .` or `git add -A`
- If a file has both relevant and irrelevant changes → use `git add -p <file>` to stage only the relevant hunks
- After each commit, confirm it succeeded before moving to the next
- If a commit fails → report the error, stop, and explain what went wrong

### Step 6 — Summary report

After all commits are done:

```
✓ COMMITTED SUCCESSFULLY
───────────────────────────────────────────
✓ feat(auth): add JWT refresh token flow          [a1b2c3d]
✓ fix(user-profile): correct avatar upload size   [e4f5g6h]  
✓ style(hero): update hero section colors         [i7j8k9l]
✓ chore(deps): add framer-motion                  [m1n2o3p]
───────────────────────────────────────────
4 commits created · 9 files committed
Run `git log --oneline -4` to review
```

---

## Conventional Commits Reference

Format: `<type>(<scope>): <short description>`

| Type | Use for |
|---|---|
| `feat` | New feature or functionality |
| `fix` | Bug fix |
| `refactor` | Code restructure with no behavior change |
| `style` | Visual/formatting changes (CSS, spacing, colors) |
| `chore` | Config, tooling, deps, build scripts |
| `test` | Adding or updating tests |
| `docs` | Documentation, comments, README |
| `perf` | Performance improvement |
| `ci` | CI/CD pipeline changes |

**Scope** = the domain/module affected: `auth`, `user`, `hero`, `deps`, `api`, `ui`, etc.

**Description rules:**
- Lowercase, no period at end
- Imperative mood: "add", "fix", "update", "remove" — not "added", "fixes", "updating"
- Max 72 characters total
- Must describe *what* the change does, not *how*

**Examples:**
```
feat(study-abroad): add destination filtering by country
fix(hero): remove double dark overlay causing excess darkness  
refactor(user-service): extract email validation to util
style(landing): apply cerulean & charcoal palette to hero section
chore(deps): upgrade next.js to 15.1.0
test(auth): add unit tests for JWT refresh flow
docs(readme): update setup instructions for new env vars
```

---

## Edge Cases

**Renamed files:** Group rename + any edits to the renamed file together. Use `refactor` or `feat` depending on context.

**Deleted files:** Group deletions with the commit that makes them logical — e.g., deleting an old component while adding its replacement = one `refactor` commit.

**Generated files** (`*.lock`, `*.generated.ts`, `dist/`): Always group with the commit that caused them. Never commit generated files alone.

**Migration files** (database): Always their own commit: `feat(db): add migration for user roles table`

**`.env.example` changes**: Group with the feature that required the new env var.

**Partially related files:** When unsure whether two files belong together, ask: *"Would reverting one of these commits without the other break something?"* If yes → same commit. If no → separate commits.

**Nothing meaningful to split:** If all changes are truly one logical unit (e.g., everything is part of one small feature) → make one single well-named commit. Don't force splits.
