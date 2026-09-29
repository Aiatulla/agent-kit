#!/usr/bin/env bash
# check-with-limit.sh fast|full: runs the project's scripts/verify.sh <mode>
# (fast after edits, full on Stop) in projects that opted in through
# .agent-kit.json, and enforces the 3-failure stop rule per session and mode.

mode=${1:-fast}
command -v jq >/dev/null 2>&1 || exit 0

input=$(cat)
cwd=$(printf '%s' "$input" | jq -r '.cwd // empty')
session=$(printf '%s' "$input" | jq -r '.session_id // "none"' | tr -c 'A-Za-z0-9_-' _)
[ -n "$cwd" ] || cwd=$PWD

top=$(cd "$cwd" 2>/dev/null && git rev-parse --show-toplevel 2>/dev/null) || exit 0
[ -f "$top/.agent-kit.json" ] || exit 0
[ -x "$top/scripts/verify.sh" ] || exit 0

common=$(cd "$top" && cd "$(git rev-parse --git-common-dir)" && pwd) || exit 0
branch=$(cd "$top" && git rev-parse --abbrev-ref HEAD 2>/dev/null) || branch=unknown
state_dir=$common/agent-kit
counter=$state_dir/failures-$session-$mode
mkdir -p "$state_dir"

log_event() {
  printf '%s\t%s\t%s\t%s\n' "$(date -u +%Y-%m-%dT%H:%M:%SZ)" "$1" "$branch" "$mode" >> "$common/agent-metrics.tsv"
}

if output=$(cd "$top" && ./scripts/verify.sh "$mode" </dev/null 2>&1); then
  rm -f "$counter"
  log_event verify-pass
  exit 0
fi

failures=$(cat "$counter" 2>/dev/null || echo 0)
failures=$((failures + 1))
echo "$failures" > "$counter"
log_event "verify-fail-$failures"

# After the stop message, let the agent finish so it can report to the user.
[ "$failures" -gt 3 ] && exit 0

# ponytail: last 60 lines only, so long logs do not flood the agent's context.
echo "scripts/verify.sh $mode failed (failure $failures of 3):" >&2
printf '%s\n' "$output" | tail -n 60 >&2

if [ "$failures" -lt 3 ]; then
  echo "Fix the root cause, do not weaken checks." >&2
else
  cat >&2 <<'EOF'
Stop rule: the same check failed 3 times. Stop working on it now.
Report the exact error, what you tried and why each attempt failed, your root-cause hypothesis, and what you need from the user.
EOF
fi
exit 2
