# agent-kit

One repo that gives your AI coding agents the same rules, commands, reviewer, hooks, and skills on every machine.
It supports Claude Code and Gemini CLI today, and a new tool is one adapter file.

The kit has three tiers:

- **Global**: stack-free rules, commands (`/spec`, `/plan`, `/implement`, `/lesson`), the reviewer agent, hooks, and skills, installed into each tool on your machine.
- **Stack**: rules, lint presets, and checks for one stack (`nextjs`, `fastapi`), copied into a project by `kit sync`.
- **Project**: everything specific to one project, which lives in that project.

Dependencies: bash (3.2 or newer), git, jq. macOS and Linux.

## Install

```sh
git clone https://github.com/Aiatulla/agent-kit.git ~/agent-kit
~/agent-kit/install.sh
```

`install.sh` detects Claude Code and Gemini CLI and, for each one, creates one symlink per item into the kit:

- Claude Code: `~/.claude/rules/agent-kit.md` (global rules), `~/.claude/commands/*`, `~/.claude/agents/reviewer.md`, `~/.claude/skills/*`, and the hooks merged into `~/.claude/settings.json`.
- Gemini CLI: `~/.gemini/GEMINI.md`, `~/.gemini/commands/*.toml` (generated from the commands), `~/.gemini/skills/*`.
- `kit` on `~/.local/bin`.

Your own files are never overwritten: anything in the way is moved to `~/.agent-kit-backup/<timestamp>/` first.
`settings.json` is merged, never linked, and running the installer again changes nothing.
Run `./install.sh --dry-run` to see what it would do.

## Update

```sh
cd ~/agent-kit && git pull
```

Links point into the clone, so a pull updates every tool at once.
Run `./install.sh` again only when the pull added new commands, agents, or skills, and `kit sync` in projects to update their stack copies.

## Use it in a project

Create `.agent-kit.json` at the project root, mapping each directory to its stack:

```json
{"stacks": {"frontend": "nextjs", "backend": "fastapi"}}
```

Then run `kit sync` in the project.
It copies the stacks into `.agent-kit/stacks/`, writes each stack's rules into that directory's `AGENTS.md` between `agent-kit` markers (your own content outside the markers is kept), writes `docs/inventory/<stack>.md`, generates `scripts/verify.sh`, installs a pre-commit hook that runs `scripts/verify.sh fast`, and records the kit version.
Commit the result: teammates and CI need nothing else installed.
It prints the one line to add to your ESLint or Ruff config to extend the stack's preset.

The file `.agent-kit.json` also turns on the global hooks for that project:
edits to tests, snapshots, and fixtures are blocked (unless `ALLOW_TEST_EDITS=1`), and `scripts/verify.sh` runs after edits and before the agent stops, with a stop rule after 3 failures.

`kit doctor` checks install links, dependencies, and whether the project is synced with the current kit.
`kit version` prints the kit version.

## Extend the kit

- **A tool**: add `adapters/<tool>.sh` with `<tool>_detect`, `<tool>_install_global`, `<tool>_uninstall_global`, `<tool>_sync_project`, and `<tool>_doctor`.
  Nothing else changes.
- **A stack**: add `stacks/<name>/` with `rules.md` (max 80 lines), `lint/`, `verify.sh` (`fast` and `full`), and `registry.sh`.
  Nothing else changes.
- **A skill**: add `skills/<name>/SKILL.md` whose `name:` matches the folder, then run `./install.sh`.
  Third-party skills go in `vendor/skills/` and are recorded in `vendor/skills-lock.json`.

Run `scripts/verify.sh full` before committing; `AGENTS.md` has the rules for working on this repo.

## Uninstall

```sh
~/agent-kit/install.sh --uninstall
```

This removes only links that point into the kit and the kit's hooks from `settings.json`, then restores your backed-up files.
