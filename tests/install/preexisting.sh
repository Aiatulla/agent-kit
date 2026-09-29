#!/usr/bin/env bash
# KIT-3: existing files are backed up before being replaced; the user's other files are untouched.
# shellcheck disable=SC2034 # variables are read inside the eval strings passed to check
. "$(dirname "$0")/../lib.sh"

mkdir -p "$HOME/.claude/commands" "$HOME/.claude/skills/commiter" "$HOME/.gemini"
echo "my spec" > "$HOME/.claude/commands/spec.md"
echo "my own" > "$HOME/.claude/commands/mine.md"
echo "my skill" > "$HOME/.claude/skills/commiter/SKILL.md"
echo "my gemini" > "$HOME/.gemini/GEMINI.md"

run_install >/dev/null 2>&1
b=$(ls -d "$HOME"/.agent-kit-backup/*/ 2>/dev/null | head -1)
check "backup dir created" '[ -n "$b" ]'
check "command backed up" '[ "$(cat "${b}.claude/commands/spec.md")" = "my spec" ]'
check "skill folder backed up" '[ "$(cat "${b}.claude/skills/commiter/SKILL.md")" = "my skill" ]'
check "gemini context backed up" '[ "$(cat "${b}.gemini/GEMINI.md")" = "my gemini" ]'
check "command replaced by link" '[ -L "$HOME/.claude/commands/spec.md" ]'
check "unrelated command untouched" '[ ! -L "$HOME/.claude/commands/mine.md" ] && [ "$(cat "$HOME/.claude/commands/mine.md")" = "my own" ]'
check "commands dir is not a link" '[ ! -L "$HOME/.claude/commands" ]'
finish
