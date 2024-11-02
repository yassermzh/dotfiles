#!/bin/bash

# Set the battery threshold (e.g., 20%)
THRESHOLD=25

# Get battery level using acpi (assuming battery is BAT0, adjust if needed)
BATTERY_LEVEL=$(acpi -b | grep -v 'Unknown' | grep -P -o '[0-9]+(?=%)')

# Get charging status (Charging or Discharging)
CHARGING_STATUS=$(acpi -b | grep -o 'Charging\|Discharging')

# Check if battery is discharging and below threshold
if [ "$CHARGING_STATUS" = "Discharging" ] && [ "$BATTERY_LEVEL" -le "$THRESHOLD" ]; then
    # Send notification using dunst
    dunstify -u critical "Battery Low" "Battery level is ${BATTERY_LEVEL}%!"
fi


# Set the file to store the last charging state
STATE_FILE="/tmp/charging_state"

# Get current battery charging status (Charging, Discharging, Full)
CHARGING_STATUS=$(acpi -b | grep -o 'Charging\|Discharging\|Full')

# If the state file doesn't exist, create it and store the initial state
if [ ! -f "$STATE_FILE" ]; then
    echo "$CHARGING_STATUS" > "$STATE_FILE"
fi

# Read the previous charging state
LAST_STATUS=$(cat "$STATE_FILE")

# If the status has changed to charging, notify the user
if [ "$CHARGING_STATUS" = "Charging" ] && [ "$LAST_STATUS" != "Charging" ]; then
    dunstify -u normal "Charging" "Battery is now charging."
fi

# If the status has changed to discharging, notify the user
if [ "$CHARGING_STATUS" = "Discharging" ] && [ "$LAST_STATUS" = "Charging" ]; then
    dunstify -u normal "Discharging" "Battery is discharging."
fi

# Update the state file with the current status
echo "$CHARGING_STATUS" > "$STATE_FILE"

