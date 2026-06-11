#!/usr/bin/env bash
set -e

scriptdir="$(dirname "$0")"

# Run postCreate.sh from each local feature — add a feature directory to enable it,
# remove it (or omit it) to disable it. Order is lexicographic by feature name.
for postcreate in "$scriptdir"/../features/*/postCreate.sh; do
  if [ -f "$postcreate" ]; then
    feature_name="$(basename "$(dirname "$postcreate")")"
    echo "[postCreate] $feature_name"
    sh "$postcreate"
  fi
done

echo "Done devcontainering."
