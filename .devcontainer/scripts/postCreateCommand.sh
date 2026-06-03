#!/usr/bin/env bash

scriptdir="$(dirname "$0")"
set -e

sh "$scriptdir/postCreate-Claude.sh"
sh $scriptdir/postCreate-OpenCode.sh

echo "Done devcontainering."
