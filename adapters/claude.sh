# shellcheck shell=bash
# adapters/claude.sh: Claude Code adapter. Sourced by install.sh and bin/kit.
# Conventions (confirmed in docs/plans/001-agent-kit-v1.md, "Tool conventions confirmed"):
# user rules in ~/.claude/rules/*.md, commands, agents, skills, hooks in settings.json.
# The global context file goes to ~/.claude/rules/agent-kit.md so ~/.claude/CLAUDE.md stays the user's.

CLAUDE_HOME=$HOME/.claude
CLAUDE_HOOKS_MARK=$KIT_DIR/global/hooks/

claude_detect() { command -v claude >/dev/null 2>&1 || [ -d "$CLAUDE_HOME" ]; }

# Prints "<source>\t<destination>" for every item the kit links.
_claude_items() {
  local f
  printf '%s\t%s\n' "$KIT_DIR/global/AGENTS.md" "$CLAUDE_HOME/rules/agent-kit.md"
  for f in "$KIT_DIR"/global/commands/*.md; do printf '%s\t%s\n' "$f" "$CLAUDE_HOME/commands/${f##*/}"; done
  for f in "$KIT_DIR"/global/agents/*.md; do printf '%s\t%s\n' "$f" "$CLAUDE_HOME/agents/${f##*/}"; done
  for f in "$KIT_DIR"/skills/*/ "$KIT_DIR"/vendor/skills/*/; do
    f=${f%/}
    printf '%s\t%s\n' "$f" "$CLAUDE_HOME/skills/${f##*/}"
  done
}

# jq filter: drop every hook whose command points into the kit, then empty groups and events.
_CLAUDE_STRIP='
  if .hooks then
    .hooks |= (with_entries(.value |= (map(.hooks |= map(select((.command // "") | contains($mark) | not)))
                                     | map(select((.hooks | length) > 0))))
               | with_entries(select((.value | length) > 0)))
    | if .hooks == {} then del(.hooks) else . end
  else . end'

_claude_hooks_json() {
  local h=$KIT_DIR/global/hooks m='Edit|Write|MultiEdit'
  jq -n --arg p "\"$h/protect-tests.sh\"" --arg c "\"$h/check-with-limit.sh\"" --arg m "$m" '{
    PreToolUse:  [{matcher: $m, hooks: [{type: "command", command: $p, timeout: 10}]}],
    PostToolUse: [{matcher: $m, hooks: [{type: "command", command: ($c + " fast"), timeout: 300}]}],
    Stop:        [{hooks: [{type: "command", command: ($c + " full"), timeout: 900}]}]
  }'
}

claude_install_global() {
  local src dest
  _claude_items | while IFS="$(printf '\t')" read -r src dest; do link "$src" "$dest"; done
  unlink_all_kit "$CLAUDE_HOME/commands" dangling
  unlink_all_kit "$CLAUDE_HOME/agents" dangling
  unlink_all_kit "$CLAUDE_HOME/skills" dangling
  json_edit "$CLAUDE_HOME/settings.json" "$_CLAUDE_STRIP"'
    | .hooks = (reduce ($new | to_entries[]) as $e (.hooks // {}; .[$e.key] = ((.[$e.key] // []) + $e.value)))' \
    --arg mark "$CLAUDE_HOOKS_MARK" --argjson new "$(_claude_hooks_json)"
}

claude_uninstall_global() {
  unlink_kit "$CLAUDE_HOME/rules/agent-kit.md"
  unlink_all_kit "$CLAUDE_HOME/commands"
  unlink_all_kit "$CLAUDE_HOME/agents"
  unlink_all_kit "$CLAUDE_HOME/skills"
  json_edit "$CLAUDE_HOME/settings.json" "$_CLAUDE_STRIP" --arg mark "$CLAUDE_HOOKS_MARK"
  remove_empty_dirs "$CLAUDE_HOME/rules" "$CLAUDE_HOME/commands" "$CLAUDE_HOME/agents" "$CLAUDE_HOME/skills" "$CLAUDE_HOME"
}

# claude_sync_project <dir>: CLAUDE.md -> AGENTS.md next to every AGENTS.md the kit manages
# (the project root and each stack directory in .agent-kit.json).
claude_sync_project() {
  local root=$1 d
  for d in . $(jq -r '.stacks // {} | keys[]' "$root/.agent-kit.json"); do
    [ -f "$root/$d/AGENTS.md" ] || continue
    if [ -L "$root/$d/CLAUDE.md" ] && [ "$(readlink "$root/$d/CLAUDE.md")" = AGENTS.md ]; then
      continue
    elif [ -e "$root/$d/CLAUDE.md" ] || [ -L "$root/$d/CLAUDE.md" ]; then
      warn "$root/$d/CLAUDE.md exists and is not a link to AGENTS.md; add @AGENTS.md to it so Claude Code loads the kit rules"
    else
      act "link $root/$d/CLAUDE.md -> AGENTS.md" ln -s AGENTS.md "$root/$d/CLAUDE.md"
    fi
  done
}

# claude_doctor: prints problems, returns the number found.
claude_doctor() {
  local src dest n=0
  while IFS="$(printf '\t')" read -r src dest; do
    if [ "$(readlink "$dest" 2>/dev/null)" != "$src" ] || [ ! -e "$dest" ]; then
      say "claude: missing or broken link $dest"
      n=$((n + 1))
    fi
  done <<EOF
$(_claude_items)
EOF
  if ! jq -e --arg mark "$CLAUDE_HOOKS_MARK" '[.hooks[]?[]?.hooks[]?.command | select(contains($mark))] | length == 3' \
      "$CLAUDE_HOME/settings.json" >/dev/null 2>&1; then
    say "claude: kit hooks missing from $CLAUDE_HOME/settings.json"
    n=$((n + 1))
  fi
  return "$n"
}
