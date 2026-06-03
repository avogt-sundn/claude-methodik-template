#!/usr/bin/env bash
# Installiert Playwright-Testabhängigkeiten. Das Chromium-Binary ist im Image
# unter /ms-playwright (PLAYWRIGHT_BROWSERS_PATH) bereits vorhanden.
# Aufrufen wenn ein tests/-Verzeichnis mit package.json existiert.

set -e

REPO_ROOT="$(git -C "$(dirname "$0")" rev-parse --show-toplevel)"

if [ -f "$REPO_ROOT/tests/package.json" ]; then
  cd "$REPO_ROOT/tests"
  npm install
  echo "Playwright test dependencies installed."
else
  echo "Skipping Playwright install: $REPO_ROOT/tests/package.json not found."
fi
