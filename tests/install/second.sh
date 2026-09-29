#!/usr/bin/env bash
# KIT-3: a second install changes nothing and does not duplicate hooks.
. "$(dirname "$0")/../lib.sh"

run_install >/dev/null 2>&1
before=$(snapshot "$HOME")
out=$(run_install 2>/dev/null)
check "second install exits 0" '[ $? -eq 0 ]'
check "home unchanged" '[ "$(snapshot "$HOME")" = "$before" ]'
check "no actions printed" '! printf "%s\n" "$out" | grep -qE "^(link|write|update|backup|remove)"'
check "hooks not duplicated" '[ "$(jq "[.hooks[][].hooks[].command] | length" "$HOME/.claude/settings.json")" = 3 ]'
finish
