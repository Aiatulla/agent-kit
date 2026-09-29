#!/usr/bin/env bash
# protect-tests.sh: PreToolUse hook for Edit, Write, MultiEdit.
# Blocks edits to test, snapshot, and fixture files in projects that opted in
# through .agent-kit.json, unless ALLOW_TEST_EDITS=1.

command -v jq >/dev/null 2>&1 || exit 0

input=$(cat)
cwd=$(printf '%s' "$input" | jq -r '.cwd // empty')
file=$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty')
[ -n "$cwd" ] || cwd=$PWD
[ -n "$file" ] || exit 0

top=$(cd "$cwd" 2>/dev/null && git rev-parse --show-toplevel 2>/dev/null) || exit 0
[ -f "$top/.agent-kit.json" ] || exit 0

log_event() {
  common=$(cd "$top" && cd "$(git rev-parse --git-common-dir)" && pwd) || return 0
  branch=$(cd "$top" && git rev-parse --abbrev-ref HEAD 2>/dev/null) || branch=unknown
  printf '%s\t%s\t%s\t%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$1" "$branch" "-" >> "$common/agent-metrics.tsv"
}

# Match on the path relative to the project root, with a leading slash, so
# directory names above the project never count.
case "$file" in
  "$top"/*) rel=/${file#"$top"/} ;;
  /*) rel=$file ;;
  *) rel=/$file ;;
esac

case "$rel" in
  */tests/*|*/test/*|*/__tests__/*|*/e2e/*|*/__snapshots__/*|*.snap|*/fixtures/*|*/testdata/*|*/golden/*|*.golden|\
  *.test.*|*.spec.*|*/test_*.py|*_test.py|*_test.go|*/conftest.py)
    ;;
  *) exit 0 ;;
esac

if [ "${ALLOW_TEST_EDITS:-}" = 1 ]; then
  log_event test-edit-allowed
  exit 0
fi

log_event test-edit-blocked
cat >&2 <<EOF
Blocked: $rel is a test, snapshot, or fixture file.
Never modify tests to make checks pass; fix the implementation instead.
If you believe this test itself is wrong, stop, explain why, and let the user decide.
The user can allow test edits for a session with ALLOW_TEST_EDITS=1.
EOF
exit 2
