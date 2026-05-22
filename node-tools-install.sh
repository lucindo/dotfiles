#!/usr/bin/env bash
set -euo pipefail

TOOLS_FILE="node-tools.txt"

if [[ ! -f "$TOOLS_FILE" ]]; then
    echo "Error: $TOOLS_FILE not found"
    exit 1
fi

echo "Installing Node.js tools globally from $TOOLS_FILE..."
echo

while IFS= read -r tool || [[ -n "$tool" ]]; do
    # Skip empty lines and comments
    [[ -z "$tool" || "$tool" =~ ^# ]] && continue

    echo "-> $tool"
    npm install -g "$tool"
done <"$TOOLS_FILE"

echo
echo "Done."
npm list -g --depth=0
