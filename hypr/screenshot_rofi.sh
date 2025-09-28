#!/bin/bash

DIR="$HOME/Pictures/screenshots"

if [ -n "$1" ]; then
    # Selected item
    file="$DIR/$1"
    swappy -f "$file"
else
    # List items
    files=$(ls -t "$DIR"/*.png | head -n 20)
    for file in $files; do
        base=$(basename "$file")
        thumb="/tmp/screenshot_thumb_$base"
        convert "$file" -thumbnail 128x128 "$thumb" 2>/dev/null
        echo -e "$base\x00icon\x1f$thumb"
    done
fi
