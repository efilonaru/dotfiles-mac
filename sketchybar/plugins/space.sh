#!/bin/bash

source "$CONFIG_DIR/colors.sh"

SID=$(echo "$NAME" | sed 's/space\.//')
FOCUSED=$(aerospace list-workspaces --focused 2>/dev/null | tr -d '[:space:]')
APPS=$(aerospace list-windows --workspace "$SID" --format '%{app-name}' 2>/dev/null)

icon_for_app() {
  case "$1" in
    "iTerm2"|"Terminal"|"Ghostty"|"Alacritty"|"kitty"|"WezTerm")
      echo ">_" ;;
    "Safari"|"Google Chrome"|"Chromium"|"Arc"|"Brave Browser"|"Firefox"|"Zen Browser")
      echo "○" ;;
    "Code"|"Visual Studio Code"|"Cursor"|"Zed"|"Nova")
      echo "</>" ;;
    "Finder")
      echo "⌘" ;;
    "Spotify")
      echo "♪" ;;
    "Slack"|"Discord"|"Telegram"|"Messages")
      echo "◉" ;;
    "Notion"|"Obsidian")
      echo "◈" ;;
    "Mail"|"Mimestream")
      echo "✉" ;;
    "Xcode")
      echo "⚒" ;;
    *)
      echo "■" ;;
  esac
}

if [ -z "$APPS" ]; then
  LABEL="—"
else
  ICONS=()
  SEEN=()
  while IFS= read -r app; do
    [ -z "$app" ] && continue
    ICON=$(icon_for_app "$app")
    already_seen=false
    for seen in "${SEEN[@]}"; do
      [ "$seen" = "$ICON" ] && already_seen=true && break
    done
    if ! $already_seen; then
      ICONS+=("$ICON")
      SEEN+=("$ICON")
    fi
  done <<< "$APPS"
  LABEL="${ICONS[*]}"
fi

if [ "$FOCUSED" = "$SID" ]; then
  sketchybar --set "$NAME" \
    label="$LABEL" \
    icon.color=$PRIMARY \
    label.color=$PRIMARY \
    background.drawing=on \
    background.color=0x18474747
else
  sketchybar --set "$NAME" \
    label="$LABEL" \
    icon.color=$SECONDARY \
    label.color=$SECONDARY \
    background.drawing=off
fi
