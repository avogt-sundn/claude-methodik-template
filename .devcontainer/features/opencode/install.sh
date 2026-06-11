#!/bin/bash
set -e

FEATURE_DIR="$(dirname "$0")"
TARGET="/home/vscode/.config/opencode"

mkdir -p "$TARGET"
cp "$FEATURE_DIR/opencode.json" "$TARGET/config.json"
chown -R vscode:vscode "$TARGET"
