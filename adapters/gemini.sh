# adapters/gemini.sh: Gemini CLI adapter. Sourced by install.sh and bin/kit.
# Conventions (confirmed in docs/plans/001-agent-kit-v1.md, "Tool conventions confirmed"):
# ~/.gemini/GEMINI.md, ~/.gemini/commands/<name>.toml with {{args}}, ~/.gemini/skills/<name>/,
# project context file names in .gemini/settings.json under context.fileName.
# Subagents and hooks are not confirmed for Gemini, so the reviewer and hooks are Claude-only.

GEMINI_HOME=$HOME/.gemini

gemini_detect() { command -v gemini >/dev/null 2>&1 || [ -d "$GEMINI_HOME" ]; }

_gemini_links() {
  local f
  printf '%s\t%s\n' "$KIT_DIR/global/AGENTS.md" "$GEMINI_HOME/GEMINI.md"
  for f in "$KIT_DIR"/skills/*/ "$KIT_DIR"/vendor/skills/*/; do
    f=${f%/}
    printf '%s\t%s\n' "$f" "$GEMINI_HOME/skills/${f##*/}"
  done
}

# _gemini_command <command.md>: prints the TOML command converted from a kit command.
# A TOML literal string (''') needs no escaping; kit commands never contain '''.
_gemini_command() {
  local name
  name=$(basename "$1" .md)
  printf '# %s\n' "$(generated_header "global/commands/$name.md")"
  printf 'description = "agent-kit /%s command"\n' "$name"
  printf "prompt = '''\n"
  sed 's/\$ARGUMENTS/{{args}}/g' "$1"
  printf "'''\n"
}

gemini_install_global() {
  local src dest f tmp
  _gemini_links | while IFS="$(printf '\t')" read -r src dest; do link "$src" "$dest"; done
  unlink_all_kit "$GEMINI_HOME/skills" dangling
  for f in "$GEMINI_HOME"/commands/*.toml; do
    [ -f "$KIT_DIR/global/commands/$(basename "$f" .toml).md" ] || remove_generated_in "${f%/*}" "${f##*/}"
  done
  tmp=$(mktemp)
  for f in "$KIT_DIR"/global/commands/*.md; do
    _gemini_command "$f" > "$tmp"
    write_file "$tmp" "$GEMINI_HOME/commands/$(basename "$f" .md).toml"
  done
  rm -f "$tmp"
}

gemini_uninstall_global() {
  unlink_kit "$GEMINI_HOME/GEMINI.md"
  unlink_all_kit "$GEMINI_HOME/skills"
  remove_generated_in "$GEMINI_HOME/commands" '*.toml'
  remove_empty_dirs "$GEMINI_HOME/commands" "$GEMINI_HOME/skills" "$GEMINI_HOME"
}

# gemini_sync_project <dir>: make Gemini load AGENTS.md files as context.
gemini_sync_project() {
  local file=$1/.gemini/settings.json tmp
  tmp=$(mktemp)
  { [ -f "$file" ] && cat "$file" || echo '{}'; } |
    jq '.context.fileName = ((([.context.fileName // empty] | flatten) + ["AGENTS.md", "GEMINI.md"]) | unique)' > "$tmp"
  if ! { [ -f "$file" ] && cmp -s "$tmp" "$file"; }; then
    act "update $file" _write_now "$tmp" "$file"
  fi
  rm -f "$tmp"
}

# gemini_doctor: prints problems, returns the number found.
gemini_doctor() {
  local src dest f n=0
  while IFS="$(printf '\t')" read -r src dest; do
    if [ "$(readlink "$dest" 2>/dev/null)" != "$src" ] || [ ! -e "$dest" ]; then
      say "gemini: missing or broken link $dest"
      n=$((n + 1))
    fi
  done <<EOF
$(_gemini_links)
EOF
  for f in "$KIT_DIR"/global/commands/*.md; do
    if ! is_generated "$GEMINI_HOME/commands/$(basename "$f" .md).toml"; then
      say "gemini: missing command $GEMINI_HOME/commands/$(basename "$f" .md).toml"
      n=$((n + 1))
    fi
  done
  return "$n"
}
