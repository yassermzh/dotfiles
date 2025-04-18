#! /bin/bash

read TOUCHPAD_ID <<< $( xinput | sed -nre '/TouchPad|Touchpad/s/.*id=([0-9]*).*/\1/p' )
state=$( xinput list-props "$TOUCHPAD_ID" | grep "Device Enabled" | grep -o "[01]$" )

# toggle touchpad
if [ "$state" -eq '1' ];then
  xinput --disable "$TOUCHPAD_ID" && notify-send -i emblem-nowrite "Touchpad" "Disabled"
else
  xinput --enable "$TOUCHPAD_ID" && notify-send -i emblem-nowrite "Touchpad" "Enabled"
  xinput set-prop "$TOUCHPAD_ID" "libinput Accel Speed" 0.4
fi

TRACKPOINT_ID=$(xinput list | grep -i trackpoint | sed -n 's/.*id=\([0-9]*\).*/\1/p')
xinput set-prop "$TRACKPOINT_ID" "libinput Accel Speed" -0.4


