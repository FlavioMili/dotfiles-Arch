#!/bin/bash

WALL_DIR="$HOME/Wallpapers"
INTERVAL=600  # time in seconds
RRHZ=120

shopt -s nullglob  # ignore unmatched globs

# Start swww daemon in background if not running
pgrep -x swww-daemon > /dev/null || swww-daemon &

sleep 0.1  # let swww-daemon initialize

while true; do
  files=("$WALL_DIR"/*.{jpg,jpeg,png,gif})
  count=${#files[@]}

  if (( count == 0 )); then
    echo "No wallpapers found in $WALL_DIR" >&2
    exit 1
  fi

  random_img="${files[RANDOM % count]}"

  # I personally recommend setting the refresh rate as transition-fps
  swww img "$random_img" --transition-type any --transition-fps $RRHZ --transition-duration 2

  sleep "$INTERVAL"
done
