#!/bin/bash

source "$CONFIG_DIR/colors.sh"

FOCUSED="${AEROSPACE_FOCUSED_WORKSPACE:-$(aerospace list-workspaces --focused 2>/dev/null | tr -d '[:space:]')}"

sketchybar --set "$NAME" icon="$FOCUSED" label.drawing=off
