#!/bin/bash

DIR=~/Pictures/screencasts
FILE="$DIR/recording-$(date +%s).mp4"
PIDFILE=/tmp/wf-recorder-pid
FILEPATH=/tmp/wf-recorder-file

if [ "$1" == "start" ]; then
    wf-recorder -g "$(slurp)" -f "$FILE" &
    echo $! > $PIDFILE
    echo "$FILE" > $FILEPATH
    notify-send "Recording started" "$FILE"
elif [ "$1" == "stop" ]; then
    if [ -f $PIDFILE ]; then
        kill -INT $(cat $PIDFILE)
        notify-send "Recording saved" "$(cat $FILEPATH)"
        rm $PIDFILE $FILEPATH
    else
        notify-send "No recording to stop"
    fi
fi

