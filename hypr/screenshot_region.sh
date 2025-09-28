#!/bin/bash
set -euo pipefail

DIR="$HOME/Pictures/screenshots"
mkdir -p "$DIR"

FILE="$DIR/screenshot-$(date "+%Y-%m-%d_%H-%M-%S").png"

# Select region and save directly to file. If selection is cancelled, exit gracefully.
if grim -g "$(slurp)" "$FILE"; then
  # Put the saved file path on the clipboard (text) for quick editing with the existing `$mod+E` binding
  printf '%s' "$FILE" | wl-copy --type text
  notify-send "Screenshot saved" "$FILE"
else
  notify-send "Screenshot canceled"
  exit 1
fi
