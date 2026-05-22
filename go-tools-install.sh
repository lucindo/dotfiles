#!/usr/bin/env bash
set -euo pipefail

TOOLS_FILE="go-tools.txt"

if [[ ! -f "$TOOLS_FILE" ]]; then
    echo "Error: $TOOLS_FILE not found"
    exit 1
fi

echo "Installing Go tools from $TOOLS_FILE..."
echo

while IFS= read -r tool || [[ -n "$tool" ]]; do
    # Skip empty lines and comments
    [[ -z "$tool" || "$tool" =~ ^# ]] && continue

    echo "-> $tool"
    go install "$tool"
done <"$TOOLS_FILE"

echo
echo "Done."
echo "Binaries installed to: $(go env GOPATH)/bin"

# Optional PATH check
GOBIN_PATH="$(go env GOPATH)/bin"

if [[ ":$PATH:" != *":$GOBIN_PATH:"* ]]; then
    echo
    echo "WARNING: $GOBIN_PATH is not in your PATH"
    echo 'Add this to your shell config:'
    echo
    echo 'export PATH="$PATH:$(go env GOPATH)/bin"'
fi
