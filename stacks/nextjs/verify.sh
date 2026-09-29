#!/usr/bin/env bash
# verify.sh fast|full for the nextjs stack. Runs in the stack directory (the one with package.json).
# fast: type check and lint. full: also the test script, if package.json defines one.
set -eu
mode=${1:-fast}

if [ -f pnpm-lock.yaml ]; then pm=pnpm
elif [ -f yarn.lock ]; then pm=yarn
elif [ -f bun.lock ] || [ -f bun.lockb ]; then pm=bun
else pm=npm
fi
case "$pm" in
  npm) x="npx --no-install" ;;
  *) x="$pm exec" ;;
esac

echo "nextjs: type check"
$x tsc --noEmit
echo "nextjs: lint"
$x eslint . --max-warnings 0

if [ "$mode" = full ]; then
  if jq -e '.scripts.test' package.json >/dev/null 2>&1; then
    echo "nextjs: tests"
    CI=true $pm run test
  else
    echo "nextjs: no test script in package.json" >&2
    exit 1
  fi
fi
