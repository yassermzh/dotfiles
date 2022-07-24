#!/bin/bash

# You can call this script like this:
# $./brightness.sh up
# $./brightness.sh down

function get_brightness {
  brightnessctl | awk '/Current brightness:/{ print $4 }' | sed 's/[%()]//g'
}

function send_notification {
    brightness=`get_brightness`
    # Make the bar with the special character ─ (it's not dash -)
    # https://en.wikipedia.org/wiki/Box-drawing_character
    bar=$(seq -s "─" $(($brightness / 5)) | sed 's/[0-9]//g')
    # Send the notification
    dunstify -i audio-volume-muted-blocking -t 800 -r 2593 -u normal "$brightness % $bar"
}

case $1 in
    up)
    brightnessctl set 401+ -d intel_backlight > /dev/null
    send_notification
    ;;
    down)
    brightnessctl set 401- -d intel_backlight > /dev/null
    send_notification
    ;;
esac
