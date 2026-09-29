#!/usr/bin/env bash
# Tests for global/hooks/check-with-limit.sh. Run: bash tests/hooks/check_with_limit.sh
set -u
hook=$(cd "$(dirname "$0")/../../global/hooks" && pwd)/check-with-limit.sh
tmp=$(mktemp -d)
trap 'rm -rf "$tmp"' EXIT
fails=0

# expect <name> <expected exit> <stderr substring or empty> <cwd> <mode> <session>
expect() {
  name=$1 want=$2 msg=$3 cwd=$4 mode=$5 session=$6
  json=$(jq -n --arg cwd "$cwd" --arg s "$session" '{session_id: $s, cwd: $cwd, hook_event_name: "Stop", stop_hook_active: false}')
  err=$(printf '%s' "$json" | bash "$hook" "$mode" 2>&1 >/dev/null)
  got=$?
  if [ "$got" != "$want" ] || { [ -n "$msg" ] && ! printf '%s' "$err" | grep -q "$msg"; }; then
    echo "FAIL $name: exit $got (want $want), stderr: $err"
    fails=$((fails + 1))
  else
    echo "ok   $name"
  fi
}

plain=$tmp/plain
proj=$tmp/proj
git init -q "$plain"
git init -q "$proj"
echo '{}' > "$proj/.agent-kit.json"
mkdir -p "$plain/scripts" "$proj/scripts"
# verify.sh passes or fails depending on a marker file, and echoes its mode.
cat > "$proj/scripts/verify.sh" <<'EOF'
#!/usr/bin/env bash
echo "verify mode=$1"
[ -f pass ]
EOF
chmod +x "$proj/scripts/verify.sh"
cp "$proj/scripts/verify.sh" "$plain/scripts/verify.sh"

expect "no .agent-kit.json exits 0 even when verify fails" 0 "" "$plain" fast s1

touch "$proj/pass"
expect "verify passing" 0 "" "$proj" fast s1
rm "$proj/pass"
expect "failure 1" 2 "Fix the root cause" "$proj" fast s1
expect "failure 1 shows verify output" 2 "verify mode=fast" "$proj" fast s2
expect "failure 2" 2 "Fix the root cause, do not weaken checks" "$proj" fast s1
expect "failure 3 gives stop rule" 2 "Stop rule" "$proj" fast s1
expect "failure 4 exits 0 so the agent can report" 0 "" "$proj" fast s1
expect "other mode has its own counter" 2 "failure 1 of 3" "$proj" full s1
touch "$proj/pass"
expect "pass resets the counter" 0 "" "$proj" fast s1
rm "$proj/pass"
expect "after reset, failure 1 again" 2 "failure 1 of 3" "$proj" fast s1

rm "$proj/scripts/verify.sh"
expect "no verify.sh exits 0" 0 "" "$proj" fast s3

metrics=$proj/.git/agent-metrics.tsv
if grep -q "	verify-pass	" "$metrics" && grep -q "	verify-fail-3	" "$metrics"; then
  echo "ok   metrics rows appended"
else
  echo "FAIL metrics rows missing in $metrics"
  fails=$((fails + 1))
fi

[ "$fails" -eq 0 ] || { echo "$fails failed"; exit 1; }
