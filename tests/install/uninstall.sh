#!/usr/bin/env bash
# KIT-3: uninstall removes only kit links and restores the original home exactly.
. "$(dirname "$0")/../lib.sh"

mkdir -p "$HOME/.claude/commands" "$HOME/.gemini/commands"
echo "my spec" > "$HOME/.claude/commands/spec.md"
echo "my own" > "$HOME/.claude/commands/mine.md"
echo "my gemini" > "$HOME/.gemini/GEMINI.md"
echo "prompt = 'x'" > "$HOME/.gemini/commands/mine.toml"
printf '{\n    "model": "opus"\n}\n' > "$HOME/.claude/settings.json"
before=$(snapshot "$HOME")

run_install >/dev/null 2>&1
run_install >/dev/null 2>&1
run_install --uninstall >/dev/null 2>&1
check "uninstall exits 0" '[ $? -eq 0 ]'
after=$(snapshot "$HOME")
check "home restored to its original state" '[ "$after" = "$before" ]'
[ "$after" = "$before" ] || diff <(echo "$before") <(echo "$after")

rm -rf "$HOME" && mkdir -p "$HOME"
before=$(snapshot "$HOME")
run_install >/dev/null 2>&1
run_install --uninstall >/dev/null 2>&1
check "fresh home restored after install and uninstall" '[ "$(snapshot "$HOME")" = "$before" ]'
finish
