#!/usr/bin/env bash

update() {
  NOTIFICATIONS="$(gh api notifications | jq 'length')"

  args=()
  if [ ! "$NOTIFICATIONS" = "0" ]; then
    args+=(--set $NAME icon= label="$NOTIFICATIONS" width=dynamic)
  else
    args+=(--set $NAME icon="" label="" width=0)
  fi

  sketchybar -m "${args[@]}"
}

mouse_clicked() {
  open -a firefox -g https://github.com/notifications
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
