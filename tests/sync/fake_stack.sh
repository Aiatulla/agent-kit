#!/usr/bin/env bash
# KIT-5: a new stack is one folder in stacks/, synced with no other change.
. "$(dirname "$0")/../lib.sh"

copy=$TMP/kit
mkdir -p "$copy"
(cd "$KIT" && tar -cf - --exclude .git .) | (cd "$copy" && tar -xf -)
s=$copy/stacks/zzz
mkdir -p "$s/lint"
printf '## zzz rules\n\n- Always zzz.\n' > "$s/rules.md"
printf '# zzz lint preset\n' > "$s/lint/zzz.toml"
printf '#!/usr/bin/env bash\necho "zzz verify $1"\n' > "$s/verify.sh"
printf '#!/usr/bin/env bash\nmkdir -p "$1/docs/inventory" && echo "# zzz" > "$1/docs/inventory/zzz.md"\n' > "$s/registry.sh"
chmod +x "$s/verify.sh" "$s/registry.sh"

p=$TMP/project
mkdir -p "$p/svc"
git -C "$p" init -q
echo '{"stacks": {"svc": "zzz"}}' > "$p/.agent-kit.json"
(cd "$p" && "$BASH" "$copy/bin/kit" sync >/dev/null 2>&1)
check "sync exits 0" '[ $? -eq 0 ]'
check "stack copied" '[ -f "$p/.agent-kit/stacks/zzz/rules.md" ]'
check "rules block written" 'grep -q "Always zzz." "$p/svc/AGENTS.md"'
check "inventory written" '[ -f "$p/svc/docs/inventory/zzz.md" ]'
check "verify runs the new stack" '"$p/scripts/verify.sh" full | grep -q "zzz verify full"'
finish
