#!/usr/bin/env bash

update() {
  EVENT=$(icalBuddy -ea -ic 'Personal,Work' -eed -n -nc -nrd -ea -iep datetime,title -b '' -ps '| |' eventsNow | head -n 1)
  args=()
  if [ ! "$EVENT" = "" ]; then
    args+=(--set $NAME icon= label="$EVENT" width=dynamic)
  else
    args+=(--set $NAME icon="" label="" width=0)
  fi

  sketchybar -m "${args[@]}"
}

mouse_clicked() {
  open -a Cron
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
