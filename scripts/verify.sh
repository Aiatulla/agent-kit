#!/usr/bin/env bash
# scripts/verify.sh fast|full: self-check for agent-kit. full also runs every test in tests/.
# Patterns below are written so they never match their own source line.
set -u
cd "$(dirname "$0")/.." || exit 1
mode=${1:-fast}
fails=0

fail() { echo "FAIL: $*"; fails=$((fails + 1)); }
# Tracked and new files, without ignored ones (the task prompt is excluded through .git/info/exclude).
files() { git ls-files -co --exclude-standard | while IFS= read -r f; do [ -f "$f" ] && printf '%s\n' "$f"; done; }
shell_files() { files | grep -E '(\.sh$|^bin/kit$)'; }

# Skills: folder name equals frontmatter name, description not empty.
for d in skills/*/ vendor/skills/*/; do
  d=${d%/}
  f=$d/SKILL.md
  [ -f "$f" ] || { fail "$d has no SKILL.md"; continue; }
  name=$(awk '/^---$/ { n++; next } n == 1 && /^name:/ { sub(/^name:[[:space:]]*/, ""); print; exit }' "$f")
  [ "$name" = "${d##*/}" ] || fail "$f: name '$name' does not match folder '${d##*/}'"
  awk '/^---$/ { n++; next } n == 1 && /^description:[[:space:]]*[^[:space:]]/ { found = 1 }
       n == 1 && /^description:[[:space:]]*[>|]/ { getline; if ($0 ~ /[^[:space:]]/) found = 1 }
       END { exit !found }' "$f" || fail "$f: empty description"
done

# No absolute user paths outside tests/.
hits=$(files | grep -v '^tests/' | while IFS= read -r f; do grep -lE '/(Users|home)/[A-Za-z0-9_]' "$f"; done)
[ -z "$hits" ] || fail "absolute user paths in: $(echo $hits)"

# No leftovers.
[ -z "$(find . -name .DS_Store -not -path './.git/*')" ] || fail ".DS_Store files present"
[ ! -e _migrate ] || fail "_migrate/ still exists"

# Global tier is stack-free and short; stacks follow the contract.
hits=$(grep -rilwE 'next\.?js|react|fastapi|sqlalchemy|pydantic|tailwind|alembic' global || true)
[ -z "$hits" ] || fail "stack names in global/: $(echo $hits)"
n=$(wc -l < global/AGENTS.md)
[ "$n" -le 150 ] || fail "global/AGENTS.md has $n lines (max 150)"
for s in stacks/*/; do
  s=${s%/}
  for c in rules.md lint verify.sh registry.sh; do
    [ -e "$s/$c" ] || fail "$s is missing $c"
  done
  [ -x "$s/verify.sh" ] && [ -x "$s/registry.sh" ] || fail "$s scripts are not executable"
  [ -f "$s/rules.md" ] && n=$(wc -l < "$s/rules.md") && [ "$n" -gt 80 ] && fail "$s/rules.md has $n lines (max 80)"
done

# Secrets: real key formats, not words like "token".
secret='(-----BEGIN [A-Z ]*PRIVATE KEY-----|AKIA[0-9A-Z]{16}|gh[pousr]_[A-Za-z0-9]{36}|github_pat_[A-Za-z0-9_]{50,}|sk-[A-Za-z0-9_-]{32,}|xox[abprs]-[A-Za-z0-9-]{10,}|AIza[0-9A-Za-z_-]{35})'
hits=$(files | while IFS= read -r f; do grep -lE "$secret" "$f"; done)
[ -z "$hits" ] || fail "possible secrets in: $(echo $hits)"

# Bash 3.2 and BSD compatibility.
banned='(declare[[:space:]]+-A|\bmap''file\b|\bread''array\b|\$\{[A-Za-z_]+(,,|\^\^)\}|sed[[:space:]]+-i([[:space:]]|$))'
hits=$(shell_files | while IFS= read -r f; do grep -nE "$banned" "$f" | sed "s|^|$f:|"; done)
[ -z "$hits" ] || fail "bash 3.2 or GNU-only constructs:
$hits"

if command -v shellcheck >/dev/null 2>&1; then
  # shellcheck disable=SC2046
  shellcheck -S warning -x $(shell_files) || fail "shellcheck"
else
  echo "warning: shellcheck not installed, skipped"
fi

if [ "$mode" = full ]; then
  for t in tests/*/*.sh; do
    [ "$t" = tests/lib.sh ] && continue
    if out=$("$BASH" "$t" 2>&1); then
      echo "pass $t"
    else
      printf '%s\n' "$out" | grep -v '^ok ' | tail -n 20
      fail "$t"
    fi
  done
fi

if [ "$fails" -eq 0 ]; then echo "verify $mode: ok"; else echo "verify $mode: $fails failure(s)"; exit 1; fi
