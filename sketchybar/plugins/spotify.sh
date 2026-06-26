#!/bin/sh

if ! pgrep -x "Spotify" > /dev/null; then
  sketchybar --set "$NAME" drawing=off
  exit 0
fi

STATE=$(osascript -e 'tell application "Spotify" to player state as string' 2>/dev/null)

if [ "$STATE" = "playing" ]; then
  TRACK=$(osascript -e 'tell application "Spotify" to name of current track' 2>/dev/null)
  ARTIST=$(osascript -e 'tell application "Spotify" to artist of current track' 2>/dev/null)
  LABEL=$(echo "$ARTIST - $TRACK" | awk '{if(length($0)>40) print substr($0,1,40)"..."; else print $0}')
  sketchybar --set "$NAME" label="$LABEL" drawing=on
else
  sketchybar --set "$NAME" drawing=off
fi
