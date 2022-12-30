#!/usr/bin/env sh

update() {
  NOTIFICATIONS="$(gh api notifications)"
  COUNT="$(echo "$NOTIFICATIONS" | jq 'length')"
  args=()
  if [ "$NOTIFICATIONS" = "[]" ]; then
    args+=(--set $NAME icon= label="0")
  else
    args+=(--set $NAME icon= label="$COUNT")
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
