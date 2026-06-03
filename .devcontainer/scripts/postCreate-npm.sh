#!/usr/bin/env bash

# Setzt einen Auth-Token für den lokalen npm-Mirror (Verdaccio unter ${NPM_MIRROR}).
# Entfernen wenn kein lokaler npm-Mirror vorhanden ist.

npm config set "//${NPM_MIRROR}/:_authToken" dummy-token

echo "npm mirror token set for ${NPM_MIRROR}"
