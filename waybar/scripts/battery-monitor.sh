#!/bin/bash
# Battery monitoring script for Hyprland/Arch Linux
# Monitors battery levels and sends notifications when low

# Configuration
WARNING_LEVEL=30
CRITICAL_LEVEL=20
HIBERNATE_LEVEL=10
NOTIFICATION_TIMEOUT=10000  # 10 seconds in milliseconds

# File to track last notification sent (to avoid spam)
NOTIFICATION_LOG="/tmp/battery_notifications.log"

# Create notification log if it doesn't exist
touch "$NOTIFICATION_LOG"

# Function to send notification
send_notification() {
    local urgency="$1"
    local message="$2"
    local timeout="$3"

    if ! notify-send -u "$urgency" -t "$timeout" "Battery Alert" "$message"; then
        echo "Error sending notification: $?"
    fi
}

# Function to check if we already sent this notification recently
already_notified() {
    local level="$1"
    local current_time=$(date +%s)
    local last_notification=$(grep "^$level:" "$NOTIFICATION_LOG" | cut -d: -f2 2>/dev/null || echo 0)

    # If last notification was more than 10 minutes ago, allow new notification
    if [ $((current_time - last_notification)) -gt 600 ]; then
        return 1  # Not recently notified
    else
        return 0  # Recently notified
    fi
}

# Function to log notification
log_notification() {
    local level="$1"
    local current_time=$(date +%s)

    # Remove old entries for this level
    sed -i "/^$level:/d" "$NOTIFICATION_LOG"
    # Add new entry
    echo "$level:$current_time" >> "$NOTIFICATION_LOG"
}

# Check if battery exists
if [ ! -d "/sys/class/power_supply/BAT0" ]; then
    echo "No battery found"
    exit 1
fi

# Get battery information
CAPACITY=$(cat /sys/class/power_supply/BAT0/capacity 2>/dev/null)
STATUS=$(cat /sys/class/power_supply/BAT0/status 2>/dev/null)

# Check if we have valid data
if [ -z "$CAPACITY" ] || [ -z "$STATUS" ]; then
    echo "Unable to read battery information"
    exit 1
fi

echo "Battery: $CAPACITY% ($STATUS)"

# Only check when discharging
if [ "$STATUS" != "Discharging" ]; then
    echo "Battery is not discharging, exiting"
    exit 0
fi

# Check critical level first (most important)
if [ "$CAPACITY" -le "$HIBERNATE_LEVEL" ]; then
    if ! already_notified "hibernate"; then
        send_notification "critical" "Battery critically low! System will hibernate soon!" "$NOTIFICATION_TIMEOUT"
        log_notification "hibernate"
    fi
# Check critical level
elif [ "$CAPACITY" -le "$CRITICAL_LEVEL" ]; then
    if ! already_notified "critical"; then
        send_notification "critical" "Battery critically low! Please plug in your charger immediately!" "$NOTIFICATION_TIMEOUT"
        log_notification "critical"
    fi
# Check warning level
elif [ "$CAPACITY" -le "$WARNING_LEVEL" ]; then
    if ! already_notified "warning"; then
        send_notification "normal" "Battery low! $CAPACITY% remaining. Consider plugging in your charger." "$NOTIFICATION_TIMEOUT"
        log_notification "warning"
    fi
fi
