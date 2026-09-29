#!/usr/bin/env bash
# KIT-4: a new tool is one file in adapters/, picked up with no other change.
. "$(dirname "$0")/../lib.sh"

copy=$TMP/kit
mkdir -p "$copy"
(cd "$KIT" && tar -cf - --exclude .git .) | (cd "$copy" && tar -xf -)
cat > "$copy/adapters/zzz.sh" <<'ADAPTER'
zzz_detect() { return 0; }
zzz_install_global() { echo "zzz installed" > "$HOME/zzz.txt"; }
zzz_uninstall_global() { rm -f "$HOME/zzz.txt"; }
zzz_sync_project() { :; }
zzz_doctor() { echo "zzz doctor ran"; return 0; }
ADAPTER

"$BASH" "$copy/install.sh" >/dev/null 2>&1
check "install ran the new adapter" '[ "$(cat "$HOME/zzz.txt" 2>/dev/null)" = "zzz installed" ]'
check "kit doctor ran the new adapter" '"$BASH" "$copy/bin/kit" doctor 2>/dev/null | grep -q "zzz doctor ran"'
"$BASH" "$copy/install.sh" --uninstall >/dev/null 2>&1
check "uninstall ran the new adapter" '[ ! -e "$HOME/zzz.txt" ]'
finish
