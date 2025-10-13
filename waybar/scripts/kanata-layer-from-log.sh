#!/bin/bash

# Script to detect current kanata layer by reading kanata logs
# This monitors kanata's log output to detect layer switches

LOG_FILE="$HOME/.config/cache/kanata.log"
LAYER_STATE_FILE="$HOME/.config/cache/kanata-current-layer"

# Function to get current layer from log
get_current_layer_from_log() {
    if [[ ! -f "$LOG_FILE" ]]; then
        echo "unknown"
        return
    fi

    # Always get the LAST deflayer mentioned in the entire log file
    # This ensures we get the most recent layer regardless of timing
    local latest_layer
    latest_layer=$(grep "deflayer " "$LOG_FILE" | tail -1 | sed 's/^[[:space:]]*(deflayer \([a-zA-Z0-9_-]*\)).*/\1/' | sed 's/^[[:space:]]*(deflayer \([a-zA-Z0-9_-]*\)$/\1/')

    if [[ -z "$latest_layer" ]]; then
        echo "unknown"
    else
        echo "$latest_layer"
    fi
}

# Function to map kanata layer names to user-friendly names
map_layer_name() {
    case "$1" in
        "default")
            echo "qwerty"
            ;;
        "colemak")
            echo "colemak"
            ;;
        "lNm")
            echo "numpad"
            ;;
        "lNv")
            echo "navigation"
            ;;
        "lS")
            echo "symbols"
            ;;
        "lUpperCase")
            echo "uppercase"
            ;;
        "transparent")
            echo "default"
            ;;
        *)
            echo "$1"
            ;;
    esac
}

# Function to detect layer in real-time
detect_layer() {
    # Check if kanata is running
    if ! pgrep -f "kanata.*kanata-linux.kbd" > /dev/null; then
        echo "No Kanata"
        return
    fi

    # Get current layer from log
    local raw_layer
    raw_layer=$(get_current_layer_from_log)

    # Map to user-friendly name
    map_layer_name "$raw_layer"
}

# Main execution
case "$1" in
    "get" | "")
        # Always parse the log file directly to get the latest layer
        detect_layer
        ;;
    "raw")
        # Get raw layer name from kanata (before mapping)
        if ! pgrep -f "kanata.*kanata-linux.kbd" > /dev/null; then
            echo "No Kanata"
        else
            get_current_layer_from_log
        fi
        ;;
    *)
        # Default: get current layer
        detect_layer
        ;;
esac