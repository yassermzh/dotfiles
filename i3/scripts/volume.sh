#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
  pacmd list-sinks|grep -A 15 '* index'| awk '/volume: front/{ print $5 }' | sed 's/[%|,]//g' 
}

function is_mute {
  pacmd list-sinks | grep -A 15 '* index'| awk '/muted: /{print $2}'
}

function send_notification {
    volume=`get_volume`
    # bar=$(seq -s "─" $(($volume / 5)) | sed 's/[0-9]//g')
    # Send the notification
    dunstify -i audio-volume-muted-blocking -t 800 -r 2593 -u normal "volume: $volume%"
}

case $1 in
    up)
    # Set the volume on (if muted it was)
    pactl set-sink-mute @DEFAULT_SINK@ off > /dev/null
    # Up the volume (+ 5%)
    volume=`get_volume`
    volume=$((volume + 5 > 200 ? 200 : volume + 5))
    pactl set-sink-volume @DEFAULT_SINK@ "$volume%" > /dev/null
    send_notification
    ;;
    down)
    pactl set-sink-mute @DEFAULT_SINK@ off > /dev/null
    volume=`get_volume`
    volume=$((volume - 5 > 0 ? volume - 5 : 0))
    pactl set-sink-volume @DEFAULT_SINK@ "$volume%" > /dev/null
    send_notification
    ;;
    mute)
    # Toggle mute
    pactl set-sink-mute @DEFAULT_SINK@ toggle > /dev/null
    if [ `is_mute` == "yes" ]; then
        dunstify -i audio-volume-muted -t 800 -r 2593 -u normal "Mute"
    else
        send_notification
    fi
    ;;
esac
