#!/usr/bin/env bash
# KIT-3: an existing settings.json keeps its other keys and hooks through install and uninstall.
# shellcheck disable=SC2034 # variables are read inside the eval strings passed to check
. "$(dirname "$0")/../lib.sh"

mkdir -p "$HOME/.claude"
jq -n '{model: "opus", permissions: {allow: ["Bash(ls)"]},
        hooks: {Stop: [{hooks: [{type: "command", command: "say done"}]}],
                PreToolUse: [{matcher: "Bash", hooks: [{type: "command", command: "guard.sh"}]}]}}' \
  > "$HOME/.claude/settings.json"
s=$HOME/.claude/settings.json

run_install >/dev/null 2>&1
check "foreign keys preserved" '[ "$(jq -c ".model, .permissions" "$s" | tr -d "\n")" = "\"opus\"{\"allow\":[\"Bash(ls)\"]}" ]'
check "foreign hooks preserved" 'jq -e "[.hooks[][].hooks[].command] | index(\"say done\") and index(\"guard.sh\")" "$s" >/dev/null'
check "kit hooks added" '[ "$(jq "[.hooks[][].hooks[].command | select(contains(\"agent-kit\") or contains(\"global/hooks\"))] | length" "$s")" = 3 ]'
check "settings.json is a file, not a link" '[ -f "$s" ] && [ ! -L "$s" ]'

jq '.theme = "dark"' "$s" > "$s.tmp" && mv "$s.tmp" "$s"
run_install --uninstall >/dev/null 2>&1
check "kit hooks removed on uninstall" '[ "$(jq "[.hooks[][].hooks[].command] | length" "$s")" = 2 ]'
check "keys added after install survive uninstall" '[ "$(jq -r .theme "$s")" = dark ]'
finish
