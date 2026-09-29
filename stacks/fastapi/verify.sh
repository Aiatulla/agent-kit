#!/usr/bin/env bash
# verify.sh fast|full for the fastapi stack. Runs in the stack directory (the one with pyproject.toml).
# fast: ruff, format check, mypy, exactly one Alembic head.
# full: also pytest and an Alembic upgrade, downgrade, upgrade, check cycle on a fresh database.
set -eu
mode=${1:-fast}

if [ -f uv.lock ]; then run="uv run"
elif [ -f poetry.lock ]; then run="poetry run"
else run=""
fi

echo "fastapi: ruff"
$run ruff check .
$run ruff format --check .
echo "fastapi: mypy"
$run mypy .

if [ -f alembic.ini ]; then
  heads=$($run alembic heads | grep -c . || true)
  if [ "$heads" != 1 ]; then
    echo "fastapi: expected exactly one Alembic head, found $heads" >&2
    exit 1
  fi
else
  echo "fastapi: no alembic.ini, Alembic checks skipped"
fi

[ "$mode" = full ] || exit 0

echo "fastapi: pytest"
$run pytest -q

if [ -f alembic.ini ]; then
  # Downgrading destroys data, so the cycle only runs against a database the caller
  # declares disposable. CI sets AGENT_KIT_FRESH_DB=1 with an empty database service.
  if [ "${AGENT_KIT_FRESH_DB:-}" = 1 ]; then
    echo "fastapi: alembic upgrade, downgrade, upgrade, check"
    $run alembic upgrade head
    $run alembic downgrade base
    $run alembic upgrade head
    $run alembic check
  else
    echo "fastapi: NOT VERIFIED: Alembic migration cycle needs AGENT_KIT_FRESH_DB=1 and an empty database" >&2
  fi
fi
