#!/usr/bin/env bash

update() {
  COUNT=$(osascript -e "tell application \"Mail\" to get the unread count of inbox")
  args=()
  if [ ! "$COUNT" = "0" ]; then
    args+=(--set $NAME icon= label="$COUNT" width=dynamic)
  else
    args+=(--set $NAME icon="" label="" width=0)
  fi

  sketchybar -m "${args[@]}"
}

mouse_clicked() {
  open -a Mail
  update
}

case "$SENDER" in
  "mouse.clicked") mouse_clicked
  ;;
  "forced") update
  ;;
  *) update
  ;;
esac
