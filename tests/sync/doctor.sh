#!/usr/bin/env bash
# KIT-11: kit doctor reports broken links, missing dependencies, version drift, missing blocks.
# shellcheck disable=SC2034 # variables are read inside the eval strings passed to check
. "$(dirname "$0")/../lib.sh"

kit() { "$BASH" "$KIT/bin/kit" "$@"; }
run_install >/dev/null 2>&1

out=$(kit doctor 2>&1)
check "clean install passes" '[ $? -eq 0 ] && printf "%s" "$out" | grep -q "all good"'

rm "$HOME/.claude/commands/spec.md"
ln -s "$KIT/global/commands/missing.md" "$HOME/.claude/commands/spec.md"
out=$(kit doctor 2>&1)
check "broken link reported" '[ $? -ne 0 ] && printf "%s" "$out" | grep -q "broken link .*commands/spec.md"'
run_install >/dev/null 2>&1

# PATH with every command except jq.
nojq=$TMP/nojq
mkdir -p "$nojq"
IFS=: read -r -a dirs <<< "$PATH"
for d in "${dirs[@]}"; do
  for f in "$d"/*; do
    n=${f##*/}
    [ "$n" = jq ] || [ -e "$nojq/$n" ] || { [ -x "$f" ] && ln -s "$f" "$nojq/$n"; }
  done
done
out=$(PATH=$nojq kit doctor 2>&1)
check "missing jq reported" 'printf "%s" "$out" | grep -q "missing dependency: jq"'

p=$TMP/project
mkdir -p "$p/web"
git -C "$p" init -q
echo '{"stacks": {"web": "nextjs"}}' > "$p/.agent-kit.json"
(cd "$p" && kit sync >/dev/null 2>&1)
out=$(cd "$p" && kit doctor 2>&1)
check "synced project passes" '[ $? -eq 0 ]'

jq '.kit_version = "0.9.0"' "$p/.agent-kit.json" > "$p/j" && mv "$p/j" "$p/.agent-kit.json"
out=$(cd "$p" && kit doctor 2>&1)
check "version drift reported" '[ $? -ne 0 ] && printf "%s" "$out" | grep -q "project synced with agent-kit 0.9.0"'

(cd "$p" && kit sync >/dev/null 2>&1)
printf '# only mine\n' > "$p/web/AGENTS.md"
out=$(cd "$p" && kit doctor 2>&1)
check "missing marker block reported" '[ $? -ne 0 ] && printf "%s" "$out" | grep -q "missing nextjs block in web/AGENTS.md"'
finish
