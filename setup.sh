#!/bin/sh
set -eu
dart pub get
chmod +x .githooks/pre-commit
git config --local core.hooksPath .githooks
echo "Development setup complete: pre-commit checks enabled."
