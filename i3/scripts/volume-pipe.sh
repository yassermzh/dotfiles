#!/bin/bash

# You can call this script like this:
# $./volume.sh up
# $./volume.sh down
# $./volume.sh mute

function get_volume {
  # Get the volume of the default sink using wpctl
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}' | cut -d'.' -f1
}

function is_mute {
  # Check if the default sink is muted
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q '[MUTED]' && echo "yes" || echo "no"
}

function send_notification {
  volume=$(get_volume)
  # Send the notification using dunstify
  dunstify -i audio-volume-muted-blocking -t 800 -r 2593 -u normal "volume: $volume%"
}

case $1 in
  up)
    # Unmute and increase volume (+5%)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    volume=$(get_volume)
    volume=$((volume + 5 > 100 ? 100 : volume + 5))
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "${volume}%"
    send_notification
    ;;
  down)
    # Unmute and decrease volume (-5%)
    wpctl set-mute @DEFAULT_AUDIO_SINK@ 0
    volume=$(get_volume)
    volume=$((volume - 5 < 0 ? 0 : volume - 5))
    wpctl set-volume @DEFAULT_AUDIO_SINK@ "${volume}%"
    send_notification
    ;;
  mute)
    # Toggle mute
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    if [ $(is_mute) == "yes" ]; then
      dunstify -i audio-volume-muted -t 800 -r 2593 -u normal "Mute"
    else
      send_notification
    fi
    ;;
esac
