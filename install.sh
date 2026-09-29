#!/usr/bin/env bash
# install.sh [--dry-run] [--uninstall]: install the global tier for every detected tool.
set -eu

KIT_DIR=$(cd "$(dirname "$0")" && pwd)
mode=install
DRY_RUN=0
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=1 ;;
    --uninstall) mode=uninstall ;;
    -h|--help) sed -n 2p "$0"; exit 0 ;;
    *) echo "unknown option: $arg" >&2; exit 1 ;;
  esac
done

for dep in git jq; do
  command -v "$dep" >/dev/null 2>&1 || { echo "agent-kit needs $dep; install it and run again." >&2; exit 1; }
done

. "$KIT_DIR/bin/lib.sh"

found=0
for adapter in "$KIT_DIR"/adapters/*.sh; do
  tool=$(basename "$adapter" .sh)
  # shellcheck source=/dev/null
  . "$adapter"
  if ! "${tool}_detect"; then
    say "$tool: not detected, skipped"
    continue
  fi
  found=1
  say "$tool: ${mode}ing"
  "${tool}_${mode}_global"
done
[ "$found" = 1 ] || warn "no supported tool detected; install one and run ./install.sh again"

bin_dir=$HOME/.local/bin
if [ "$mode" = install ]; then
  link "$KIT_DIR/bin/kit" "$bin_dir/kit"
  case ":$PATH:" in
    *":$bin_dir:"*) ;;
    *) warn "$bin_dir is not on PATH; add it to use the kit command" ;;
  esac
else
  unlink_kit "$bin_dir/kit"
  restore_backups
  remove_empty_dirs "$bin_dir" "$HOME/.local"
fi
say "agent-kit $KIT_VERSION: $mode done"
