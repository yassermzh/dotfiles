#!/bin/bash

# You can call this script like this:
# $./brightness.sh up
# $./brightness.sh down

function get_brightness {
  brightnessctl | awk '/Current brightness:/{ print $4 }' | sed 's/[%()]//g'
}

function send_notification {
    brightness=`get_brightness`
    # Send the notification
    dunstify -t 800 -r 2593 -u normal "brightness: $brightness%"
}

case $1 in
    up)
    brightnessctl set +5% > /dev/null
    send_notification
    ;;
    down)
    brightnessctl set 5%- > /dev/null
    send_notification
    ;;
esac
