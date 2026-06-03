#!/usr/bin/env bash

set -e

if [ -d /home/vscode/.aws ]; then
	sudo chown -R vscode:vscode /home/vscode/.aws
fi
