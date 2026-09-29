#!/usr/bin/env bash
# KIT-3: --dry-run changes nothing, for install and for uninstall.
# shellcheck disable=SC2034 # variables are read inside the eval strings passed to check
. "$(dirname "$0")/../lib.sh"

mkdir -p "$HOME/.claude/commands"
echo "my spec" > "$HOME/.claude/commands/spec.md"
before=$(snapshot "$HOME")
out=$(run_install --dry-run 2>/dev/null)
check "dry-run install leaves home byte-identical" '[ "$(snapshot "$HOME")" = "$before" ]'
check "dry-run prints planned actions" 'printf "%s\n" "$out" | grep -q "^\[dry-run\] link"'

run_install >/dev/null 2>&1
before=$(snapshot "$HOME")
run_install --uninstall --dry-run >/dev/null 2>&1
check "dry-run uninstall leaves home byte-identical" '[ "$(snapshot "$HOME")" = "$before" ]'
finish
