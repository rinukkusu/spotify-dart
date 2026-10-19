#!/bin/sh
set -eu
dart pub get
chmod +x .githooks/pre-commit
chmod +x .githooks/pre-push
git config --local core.hooksPath .githooks
echo "Development setup complete: pre-commit checks enabled."
