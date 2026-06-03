#!/usr/bin/env bash

scriptdir="$(dirname "$0")"
set -e

sh "$scriptdir/postCreate-Quarkus.sh"
sh "$scriptdir/postCreate-Claude.sh"
sh "$scriptdir/postCreate-Maven.sh"
sh "$scriptdir/postCreate-npm.sh"

echo "Done devcontainering."
