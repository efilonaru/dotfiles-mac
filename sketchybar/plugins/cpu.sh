#!/bin/sh

CPU=$(top -l 2 -n 0 | grep "CPU usage" | tail -1 | awk '{print $3}' | tr -d '%,')
sketchybar --set "$NAME" icon="󰍛" label="${CPU}%"
