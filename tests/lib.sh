# tests/lib.sh: helpers for tests/install and tests/sync. Sourced by each test.
# Every test runs against a throwaway HOME and never touches the real one.
set -u

KIT=$(cd "$(dirname "$0")/../.." && pwd)
TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
FAILS=0

# Fake claude and gemini binaries so both adapters detect their tool.
mkdir -p "$TMP/fakebin"
for t in claude gemini; do
  printf '#!/bin/sh\nexit 0\n' > "$TMP/fakebin/$t"
  chmod +x "$TMP/fakebin/$t"
done
export HOME=$TMP/home
export PATH=$TMP/fakebin:$PATH
mkdir -p "$HOME"

ok() { echo "ok   $1"; }
fail() { echo "FAIL $1"; FAILS=$((FAILS + 1)); }
check() { if eval "$2"; then ok "$1"; else fail "$1"; fi; }

# run_install [args...]: run install.sh with the shell running the tests.
run_install() { "$BASH" "$KIT/install.sh" "$@"; }

# snapshot <dir>: one line per path with link target or checksum, for exact comparisons.
snapshot() {
  (cd "$1" && find . | LC_ALL=C sort | while IFS= read -r p; do
    if [ -L "$p" ]; then echo "$p -> $(readlink "$p")"
    elif [ -f "$p" ]; then echo "$p $(cksum < "$p")"
    else echo "$p/"
    fi
  done)
}

finish() {
  [ "$FAILS" -eq 0 ] || { echo "$FAILS failed in $(basename "$0")"; exit 1; }
}
