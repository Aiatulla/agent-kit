# Plan 001: agent-kit v1

Spec: `docs/specs/001-agent-kit-v1.md`.
Resume rule: if the session is cleared, continue from the first unchecked box in "Steps".

## Approach

One tool-agnostic source tree (`global/`, `stacks/`, `skills/`, `vendor/skills/`) plus one adapter file per tool in `adapters/`.
Everything is plain bash 3.2 + git + jq, so it runs on a fresh macOS or Linux machine without a package manager.

- `install.sh` and `bin/kit` source every `adapters/*.sh` and call `<tool>_detect`, then `<tool>_install_global` / `<tool>_uninstall_global` / `<tool>_sync_project` / `<tool>_doctor`.
  The adapter name is derived from the file name, so a new tool is one new file (KIT-4).
- Shared helpers (link with backup, unlink only kit links, jq merge, generated header) live in one sourced library, `bin/lib.sh`, so adapters stay small and no logic is duplicated (KIT-6).
  This is the only addition to the target tree; it is an internal library, not a new concept.
- Global tier is installed as per-item symlinks; `settings.json` is merged with jq, never linked (KIT-2, KIT-3).
- Stacks follow the stack contract; `kit sync` discovers stacks by listing `stacks/*/`, so a new stack is one new folder (KIT-5).
- Hooks are thin wrappers around the project's `scripts/verify.sh`, which is the universal enforcement layer (pre-commit + CI) for every tool (KIT-9).

Rejected alternatives:

- Symlinking whole directories (`~/.claude/commands -> kit/global/commands`): rejected by the prompt, and it would hide the user's own files.
- Writing the kit in Python or Node for easier JSON handling: adds a runtime dependency the spec forbids (bash, git, jq only).
- Copying the global tier instead of linking: updates would need a re-install; `git pull` would no longer be enough.

## Reuse

- `.claude/commands/{spec,plan,implement,lesson}.md` and `.claude/agents/reviewer.md`: moved and edited, not rewritten.
- `scripts/scan-context.sh`: the source for both stacks' `registry.sh`.
- `scripts/spawn.sh`: moved to `global/scripts/` unchanged.
- Rules from `CLAUDE.md`, `rules/*.md`, `agents/*.md`, root `AGENTS.md`: merged into `global/AGENTS.md` and `stacks/*/rules.md`.
- `skills-lock.json`: moved to `vendor/`.

## Files to change

- `docs/specs/001-agent-kit-v1.md`, `docs/plans/001-agent-kit-v1.md`: new (this step).
- `frontend/`, `backend/`, `DESIGN.md`, `DOCS.md`: copied to `../fastapi-nextjs-starter`, then removed here.
- `.agents/skills/*` to `skills/` and `vendor/skills/`; `skills-lock.json` to `vendor/`.
- `.claude/commands/*` to `global/commands/`; `.claude/agents/reviewer.md` to `global/agents/`; `scripts/spawn.sh` to `global/scripts/`.
- `CLAUDE.md`, `GEMINI.md`, `AGENTS.md`, `rules/`, `agents/`, `scripts/{scan-context.sh,task.sh,review.sh,new-task.md}`, `plan.md` to `_migrate/` (deleted in Step 7).
- `skills/dry-kiss-rules/SKILL.md`: absolute template path made relative; duplicate `.agents/rules/CODE_RULES.md` removed.
- `.gitignore`: add `.DS_Store`; tracked `.DS_Store` removed.
- New: `README.md`, `VERSION`, `AGENTS.md` (+ `CLAUDE.md` symlink), `install.sh`, `bin/kit`, `bin/lib.sh`, `adapters/claude.sh`, `adapters/gemini.sh`.
- New: `global/AGENTS.md`, `global/hooks/protect-tests.sh`, `global/hooks/check-with-limit.sh`.
- New: `stacks/nextjs/{rules.md,lint/,verify.sh,registry.sh}`, `stacks/fastapi/{rules.md,lint/,verify.sh,registry.sh}`.
- New: `scripts/verify.sh`, `tests/hooks/`, `tests/install/`, `tests/sync/`, `.github/workflows/verify.yml`.

## Steps

- [x] 0. Preflight: clean status, prompt excluded, remote set to `agent-kit`, tag `legacy-orchestrator` created locally (not pushed), branch `restructure/agent-kit-v1`, all files read. (KIT-1)
- [ ] 1. Spec + plan committed; STOP for approval. (all)
- [ ] 2. Starter repo: clone, copy scaffolding, commit; STOP; push after approval; `git rm` scaffolding here. (KIT-1)
- [ ] 3a. `git mv` skills, vendor skills, lock file, commands, reviewer, spawn.sh; legacy sources to `_migrate/`. (KIT-1, KIT-6)
- [ ] 3b. Cleanup: `.DS_Store`, `.gitignore`, `dry-kiss-rules` path + duplicate. (KIT-6, KIT-12)
- [ ] 3c. Repo `AGENTS.md` (max 60 lines) + `CLAUDE.md` symlink; `VERSION` = 1.0.0. (KIT-4, KIT-5)
- [ ] 4a. `global/AGENTS.md` with contradiction resolutions and integrity rules, max 150 lines. (KIT-6, KIT-7, KIT-8)
- [ ] 4b. Reviewer merged, one output format, plan conformance. Commands edited (plan inventory, implement verify, spec IDs). STOP. (KIT-6, KIT-7)
- [ ] 5. Hooks + `tests/hooks/`. (KIT-9, KIT-13)
- [ ] 6a. `bin/lib.sh` + `adapters/claude.sh` + `adapters/gemini.sh`. (KIT-2, KIT-4)
- [ ] 6b. `install.sh` with `--dry-run`, `--uninstall`, backups, settings merge, `~/.local/bin/kit`. (KIT-2, KIT-3)
- [ ] 6c. `tests/install/`. (KIT-3, KIT-12, KIT-13)
- [ ] 7a. Check current stable versions of Next.js, React, FastAPI, SQLAlchemy, Pydantic; record here. (KIT-5)
- [ ] 7b. `stacks/nextjs/*` and `stacks/fastapi/*` per contract; delete `_migrate/`. (KIT-5, KIT-6)
- [ ] 8. `bin/kit sync|doctor|version` + `tests/sync/`. (KIT-10, KIT-11, KIT-13)
- [ ] 9. `scripts/verify.sh`, CI workflow, README. (KIT-8, KIT-12, KIT-13, KIT-14)
- [ ] 10. `scripts/verify.sh full` green; KIT evidence table; unrelated issues list; STOP for merge, tag, real install.

After each step from 3 on: `scripts/verify.sh fast` once it exists, tick the box, commit.

## Test list

| ID | Verified by |
| --- | --- |
| KIT-1 | `git ls-tree -r HEAD` shows no `frontend/`, `backend/`, `DESIGN.md`, `DOCS.md`, `_migrate/`; `git show legacy-orchestrator:plan.md` and `git ls-tree legacy-orchestrator` list every removed file; starter repo `git log` shows the import commit. |
| KIT-2 | `tests/install/fresh.sh`: temp `HOME`, fake `claude`/`gemini` on `PATH`, `./install.sh`; asserts context file, each command, reviewer, each skill, hooks in `settings.json`, `~/.local/bin/kit`. |
| KIT-3 | `tests/install/{second,preexisting,uninstall,dry_run,settings_merge}.sh`: second run changes nothing and does not duplicate hooks; existing files land in `~/.agent-kit-backup/<ts>/`; uninstall restores the original tree (compared with a snapshot); `--dry-run` leaves `HOME` byte-identical; foreign `settings.json` keys survive. |
| KIT-4 | `tests/install/fake_adapter.sh`: drops a throwaway `adapters/zzz.sh` into a temp copy of the kit and asserts `install.sh` and `kit doctor` call its functions with no other change. |
| KIT-5 | `scripts/verify.sh` checks every `stacks/*/` has `rules.md`, `lint/`, `verify.sh`, `registry.sh`; `tests/sync/fake_stack.sh` adds a throwaway stack folder to a temp kit copy and syncs it. |
| KIT-6 | Manual review evidence in Step 10 (grep of each global rule across `global/` and `stacks/`); `verify.sh` checks the `_migrate/` folder is gone. |
| KIT-7 | `global/AGENTS.md` sections for the three resolutions, shown at the Step 4 STOP; reviewer pass over `global/`. |
| KIT-8 | `scripts/verify.sh`: line count of `global/AGENTS.md` at most 150 and stack-name grep over `global/`. |
| KIT-9 | `tests/hooks/*.sh`: no `.agent-kit.json` exits 0; test file blocked (exit 2 + message); `ALLOW_TEST_EDITS=1` allowed; verify pass exits 0 and resets; failures 1 and 2 exit 2 with "fix the root cause"; failure 3 exits 2 with the stop-rule message; failure 4 exits 0; metrics row appended in the git common dir. |
| KIT-10 | `tests/sync/sync.sh`: fake monorepo with `frontend/` + `backend/`; asserts `.agent-kit/stacks/*`, marker blocks in each `AGENTS.md`, content outside markers kept, `scripts/verify.sh`, pre-commit hook installed, existing pre-commit hook not overwritten, version recorded; second sync gives empty `git status`. |
| KIT-11 | `tests/sync/doctor.sh`: broken link reported, missing `jq` simulated via `PATH`, version drift reported, missing marker block reported. |
| KIT-12 | `scripts/verify.sh full` exit 0 locally; `.github/workflows/verify.yml` matrix `ubuntu-latest` + `macos-latest`. |
| KIT-13 | Local runs use `/bin/bash` 3.2.57 (confirmed on this machine); CI macOS job uses the system bash; `verify.sh` greps for banned constructs (`declare -A`, `mapfile`, `readarray`, `${var,,}`, `sed -i` without a suffix argument). |
| KIT-14 | README review against the list in KIT-14; install section counted at 3 commands or fewer. |

## Tool conventions confirmed

Checked on 2026-09-29.

Claude Code (sources: https://code.claude.com/docs/en/memory, /hooks, /sub-agents, /skills):

- User context file: `~/.claude/CLAUDE.md`.
  User-level rules: `~/.claude/rules/*.md`, loaded in every project.
  `@path` imports supported.
  Claude Code v2.1.277+ reads a project `AGENTS.md` natively when no `CLAUDE.md` or `CLAUDE.local.md` exists at or above the working directory; a `CLAUDE.md` symlink to `AGENTS.md` is documented as a supported alternative.
- Commands: `~/.claude/commands/<name>.md`, still supported; commands have been merged into skills and behave the same. `$ARGUMENTS` is the argument placeholder.
- Subagents: `~/.claude/agents/<name>.md`, YAML frontmatter with required `name` and `description`, optional `tools`, `model`.
- Skills: `~/.claude/skills/<name>/SKILL.md`; a `<name>` entry may be a symlink to a directory elsewhere. The folder name `synced` is reserved.
- Hooks: `~/.claude/settings.json` key `hooks.<Event>[] = {matcher, hooks: [{type: "command", command, timeout}]}`.
  Events used: `PreToolUse`, `PostToolUse`, `Stop`. Matcher `"Edit|Write|MultiEdit"` is a plain alternation.
  `MultiEdit` is not listed in the current docs; keeping it in the matcher is harmless and covers older versions.
- Hook stdin JSON: `session_id`, `cwd`, `hook_event_name`, `tool_name`, `tool_input.file_path` (Edit/Write), `stop_hook_active` (Stop).
  Exit 2: PreToolUse blocks the tool call, stderr goes to Claude; PostToolUse shows stderr to Claude (tool already ran); Stop prevents stopping, stderr is the reason.
  `CLAUDE_PROJECT_DIR` is set for hooks.

Gemini CLI (sources: https://geminicli.com/docs/cli/gemini-md/, /custom-commands/, /skills/):

- Global context file: `~/.gemini/GEMINI.md`. User settings: `~/.gemini/settings.json`. Project settings: `.gemini/settings.json`.
- Context file name: the current key is `context.fileName` (string or array), for example `{"context": {"fileName": ["AGENTS.md", "GEMINI.md"]}}`.
  The prompt says `contextFileName`; that is the older top-level key. The adapter writes the current `context.fileName`.
- Custom commands: `~/.gemini/commands/<name>.toml`, fields `prompt` (required) and `description`; argument placeholder `{{args}}`.
- Skills: supported natively, no flag. User locations `~/.gemini/skills/` or the alias `~/.agents/skills/` (the alias wins on conflict).
  Symlinked skill folders are not documented either way; `gemini_doctor` will check that each linked skill resolves, and I will confirm on a machine with Gemini installed (not installed here).
- Not confirmed and therefore not used in v1: Gemini subagents and Gemini hooks. The reviewer and hooks are Claude-only; Gemini gets enforcement through `verify.sh` + pre-commit + CI, as the spec allows.

## Risks

- **Your current `~/.claude/CLAUDE.md` is `@RTK.md`.** Linking `global/AGENTS.md` over it would back it up and drop the RTK import.
  Proposed: the Claude adapter links the global context file to `~/.claude/rules/agent-kit.md` (loaded in every project, per the docs) and leaves `~/.claude/CLAUDE.md` alone.
  This is still a per-item symlink of the global context file, so the spec holds. I need your yes or no on this before Step 6.
- **Stack names in `global/`**: `verify.sh` greps `global/` for Next.js, React, FastAPI, SQLAlchemy, Pydantic, Tailwind, Alembic; the moved commands and reviewer must be cleaned of these words.
- **Absolute path check**: the spec itself names the patterns being checked, so the check matches `/Users/<name>` and `/home/<name>` (a path segment after the prefix), not the bare prefixes, and skips `tests/`.
- **Secrets scan false positives**: skill docs contain lines like `token: "--color-primary"`; the scan targets real key formats (private key headers, `AKIA...`, `ghp_...`, `sk-...`, `xox[bp]-...`) instead of the word `token`.
- **KIT-6 and skills**: `skills/dry-kiss-rules` and vendored design skills restate some general rules (DRY, KISS). Skills are on-demand content, not rules the kit loads; I treat KIT-6 as covering `global/` and `stacks/` and leave the open question in the spec for you.
- **Project-specific instructions** (read DOCS.md / DESIGN.md, stop if empty) leave global in Step 4. Adding them to the starter is outside Steps 2-10; I will list it as a follow-up.
- **Em dashes**: many moved files contain them. I do not rewrite third-party or moved skill content; files I write or edit are em-dash free.
- **Hook latency**: `check-with-limit.sh fast` runs after every edit in opted-in projects; stack `fast` modes must stay quick (type check + lint, no full test run).
- **shellcheck** is not installed here; `verify.sh` warns locally and CI installs it on both runners.
