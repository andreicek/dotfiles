#!/usr/bin/env sh

update() {
  PLAYING=1
  if [ "$(echo "$INFO" | jq -r '.["Player State"]')" = "Playing" ]; then
    PLAYING=0
    TRACK="$(echo "$INFO" | jq -r .Name | cut -c1-20)"
    ARTIST="$(echo "$INFO" | jq -r .Artist | cut -c1-20)"
    ALBUM="$(echo "$INFO" | jq -r .Album | cut -c1-20)"
  fi

  args=()
  args+=(--set spotify.name icon=阮)

  if [ $PLAYING -eq 0 ]; then
    if [ "$ARTIST" == "" ]; then
      args+=(--set spotify.name label="$TRACK - $ALBUM" drawing=on)
    else
      args+=(--set spotify.name label="$TRACK - $ARTIST" drawing=on)
    fi
    args+=(--set spotify.play)
  else
    args+=(--set spotify.name drawing=off)
  fi
  sketchybar -m "${args[@]}"
}

case "$SENDER" in
  "forced") exit
  ;;
  *) update
  ;;
esac
