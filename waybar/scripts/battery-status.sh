#!/bin/bash
# Simple battery check script for waybar click action
# This script is called when clicking the battery icon in waybar

# Get battery information
CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
STATUS=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)

if [ -n "$CAPACITY" ] && [ -n "$STATUS" ]; then
    notify-send -t 5000 "Battery Status" "Current: $CAPACITY%\nStatus: $STATUS"
else
    notify-send -t 3000 "Battery Status" "Unable to read battery information"
fi
