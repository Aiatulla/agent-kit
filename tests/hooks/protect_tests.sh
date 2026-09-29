#!/usr/bin/env bash
# Tests for global/hooks/protect-tests.sh. Run: bash tests/hooks/protect_tests.sh
set -u
hook=$(cd "$(dirname "$0")/../../global/hooks" && pwd)/protect-tests.sh
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
fails=0

# expect <name> <expected exit> <stderr substring or empty> <cwd> <file_path> [env...]
expect() {
  name=$1 want=$2 msg=$3 cwd=$4 file=$5
  shift 5
  json=$(jq -n --arg cwd "$cwd" --arg f "$file" '{session_id: "s1", cwd: $cwd, tool_name: "Edit", tool_input: {file_path: $f}}')
  err=$(printf '%s' "$json" | env "$@" bash "$hook" 2>&1 >/dev/null)
  got=$?
  if [ "$got" != "$want" ] || { [ -n "$msg" ] && ! printf '%s' "$err" | grep -q "$msg"; }; then
    echo "FAIL $name: exit $got (want $want), stderr: $err"
    fails=$((fails + 1))
  else
    echo "ok   $name"
  fi
}

plain=$tmp/plain
opted=$tmp/opted
git init -q "$plain"
git init -q "$opted"
echo '{}' > "$opted/.agent-kit.json"

expect "no .agent-kit.json allows test edit" 0 "" "$plain" "$plain/tests/test_a.py"
expect "not a git repo allows edit" 0 "" "$tmp" "$tmp/tests/a.test.ts"
expect "source file allowed" 0 "" "$opted" "$opted/src/app.py"
expect "tests dir blocked" 2 "Blocked" "$opted" "$opted/tests/test_api.py"
expect "ts test file blocked" 2 "stop, explain why" "$opted" "$opted/src/button.test.tsx"
expect "spec file blocked" 2 "Blocked" "$opted" "$opted/src/button.spec.ts"
expect "python test_ file blocked" 2 "Blocked" "$opted" "$opted/app/test_models.py"
expect "snapshot blocked" 2 "Blocked" "$opted" "$opted/src/__snapshots__/a.snap"
expect "fixture blocked" 2 "Blocked" "$opted" "$opted/fixtures/user.json"
expect "relative path blocked" 2 "Blocked" "$opted" "tests/test_a.py"
expect "ALLOW_TEST_EDITS=1 allows" 0 "" "$opted" "$opted/tests/test_a.py" ALLOW_TEST_EDITS=1
expect "similar directory name 'contests' allowed" 0 "" "$opted" "$opted/contests/a.py"

metrics=$opted/.git/agent-metrics.tsv
if grep -q "	test-edit-blocked	" "$metrics" && grep -q "	test-edit-allowed	" "$metrics"; then
  echo "ok   metrics rows appended"
else
  echo "FAIL metrics rows missing in $metrics"
  fails=$((fails + 1))
fi

[ "$fails" -eq 0 ] || { echo "$fails failed"; exit 1; }
