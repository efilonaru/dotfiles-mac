#!/bin/bash

TITLE=$(nowplaying-cli get title 2>/dev/null)
ARTIST=$(nowplaying-cli get artist 2>/dev/null)
STATUS=$(nowplaying-cli get playbackRate 2>/dev/null)

if [ -z "$TITLE" ] || [ "$TITLE" = "null" ]; then
  sketchybar --set nowplaying drawing=off
else
  if [ "$STATUS" = "1" ]; then
    ICON="󰎆"
  else
    ICON="󰏤"
  fi
  sketchybar --set nowplaying \
    drawing=on \
    icon="$ICON" \
    label="${ARTIST} — ${TITLE}"
fi
