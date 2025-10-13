#!/bin/bash

# Script to detect current keyboard layout and kanata layer
# Shows system layout (Farsi/English) and kanata layer (Qwerty/Colemak)

# Get system layout from Hyprland
SYSTEM_LAYOUT=$(hyprctl devices -j | jq -r '.keyboards[] | select(.name == "kanata") | .active_keymap' 2>/dev/null)

# Get script directory first
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Handle command line arguments
case "$1" in
    "toggle")
        # Note: Toggle won't actually change kanata layers since we can't control kanata directly
        # This just shows the current detected layer for information
        echo "Current kanata layer: $($SCRIPT_DIR/kanata-layer-from-log.sh get)"
        echo "Note: Toggle disabled - layers are detected automatically from kanata logs"
        exec "$0"
        ;;
    "debug")
        # Show debug information
        echo "=== Keyboard Layout Debug Info ==="
        echo "System Layout: $SYSTEM_LAYOUT"
        echo "Kanata Running: $(pgrep -f 'kanata.*kanata-linux.kbd' > /dev/null && echo 'Yes' || echo 'No')"
        echo "Detected Layer: $($SCRIPT_DIR/kanata-layer-from-log.sh raw)"
        echo "Log File: $(ls -la ~/.config/cache/kanata.log 2>/dev/null || echo 'Not found')"
        echo "State File: $(ls -la ~/.config/cache/kanata-current-layer 2>/dev/null || echo 'Not found')"
        echo "====================================="
        exec "$0"
        ;;
    *)
        # Default behavior - just display current state
        ;;
esac

# Get kanata layer from log-based detection
KANATA_LAYER=$("$SCRIPT_DIR/kanata-layer-from-log.sh" get 2>/dev/null || echo "qwerty")

# Fallback if kanata is not running
if ! pgrep -f "kanata.*kanata-linux.kbd" > /dev/null; then
    KANATA_LAYER="No Kanata"
fi

# Determine display text based on system layout and kanata layer
if [[ "$SYSTEM_LAYOUT" == *"Persian"* || "$SYSTEM_LAYOUT" == *"Farsi"* ]]; then
    echo "{\"text\": \"FA\", \"tooltip\": \"Farsi (Persian) - $KANATA_LAYER\", \"class\": \"farsi\"}"
elif [[ "$SYSTEM_LAYOUT" == *"English"* || "$SYSTEM_LAYOUT" == *"US"* ]]; then
    if [[ "$KANATA_LAYER" == "colemak" ]]; then
        echo "{\"text\": \"EN-CM\", \"tooltip\": \"English (Colemak)\", \"class\": \"english-colemak\"}"
    elif [[ "$KANATA_LAYER" == "qwerty" ]]; then
        echo "{\"text\": \"EN-QW\", \"tooltip\": \"English (Qwerty)\", \"class\": \"english-qwerty\"}"
    else
        echo "{\"text\": \"EN\", \"tooltip\": \"English - $KANATA_LAYER\", \"class\": \"english\"}"
    fi
else
    echo "{\"text\": \"⌨️ $SYSTEM_LAYOUT\", \"tooltip\": \"$SYSTEM_LAYOUT - $KANATA_LAYER\", \"class\": \"unknown\"}"
fi
