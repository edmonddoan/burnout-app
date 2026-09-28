#!/bin/bash
# Auto-commit and push any changes in the burnout-app repo.
# Runs on a schedule (cron). Commits only when there are changes.
set -u

REPO_DIR="/home/hatch/workspace/projects/burnout-app"
cd "$REPO_DIR" || exit 1

git add -A

if git diff --cached --quiet; then
  echo "$(date -u +%FT%TZ) No changes to push."
  exit 0
fi

git commit -m "auto: sync $(date -u +%Y-%m-%dT%H:%MZ)" --quiet
if git push origin main 2>&1; then
  echo "$(date -u +%FT%TZ) Pushed successfully."
else
  echo "$(date -u +%FT%TZ) Push FAILED." >&2
  exit 1
fi
