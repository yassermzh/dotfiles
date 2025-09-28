#!/bin/bash

# PLEASE REPLACE 'YOUR_PORT_HERE' WITH THE ACTUAL PORT NUMBER
PORT="20171"
HOST="127.0.0.1"

# Check if the port is open using netcat
if nc -z -w 1 $HOST $PORT &>/dev/null; then
  # Port is open - VPN is connected
  # You can replace the icon '' with any icon you prefer (e.g., from Font Awesome)
  echo '{"text": "", "tooltip": "VPN: Connected", "class": "connected"}'
else
  # Port is closed - VPN is disconnected
  # You can replace the icon '' with any icon you prefer
  echo '{"text": "", "tooltip": "VPN: Disconnected", "class": "disconnected"}'
fi
