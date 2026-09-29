#!/usr/bin/env bash
# scripts/spawn.sh <slug>: creates a ready-to-use isolated workspace for one agent
set -euo pipefail                        # stop on the first error
slug=$1
dir="../wt-$slug"

git worktree add "$dir" -b "feat/$slug"  # new folder + new branch
cp .env "$dir/.env"                      # .env is not in git, so copy it over
echo "COMPOSE_PROJECT_NAME=$slug" >> "$dir/.env"
# gives this worktree its own Docker containers, networks, and volumes (so its own test DB)

cd "$dir"
(cd frontend && pnpm install --frozen-lockfile)  # install exact locked versions
(cd backend && pip install -r requirements.txt)  # adjust to your tool (uv, poetry)
echo "Ready: cd $dir && claude"
