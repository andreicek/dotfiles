#!/usr/bin/env bash

export $(cat ~/.dotfiles/secret.env | xargs)

get_forecast() {
  STATE=$(curl --request GET \
    --url $HASS_URL/states/weather.rendiceva \
    --header "Authorization: Bearer $HASS_TOKEN" \
    --header 'Content: application/json' 2>/dev/null | jq -r '.state')

  case $STATE in
    "cloudy")
      echo ""
      ;;
    "clear-night")
      echo ""
      ;;
    "fog")
      echo ""
      ;;
    "hail")
      echo ""
      ;;
    "lightning")
      echo ""
      ;;
    "lightning-rainy")
      echo ""
      ;;
    "partlycloudy")
      echo ""
      ;;
    "pouring")
      echo ""
      ;;
    "rainy")
      echo ""
      ;;
    "snowy")
      echo ""
      ;;
    "snowy-rainy")
      echo ""
      ;;
    "sunny")
      echo ""
      ;;
    "windy")
      echo ""
      ;;
    "windy-variant")
      echo ""
      ;;
    "exceptional")
      echo ""
      ;;
  esac
}

get_temp() {
  curl --request GET \
    --url $HASS_URL/states/sensor.outside_temperature \
    --header "Authorization: Bearer $HASS_TOKEN" \
    --header 'Content: application/json' 2>/dev/null | jq -r '.state'
}

update() {
  UNIT="°C"
  TEMP=$(get_temp)

  if [ ! "$TEMP" = "" ]; then
    ICON=$(get_forecast)
    args+=(--set $NAME icon=$ICON label="$TEMP$UNIT" width=dynamic)
  else
    args+=(--set $NAME icon="" label="" width=0)
  fi

  sketchybar -m "${args[@]}"
}

mouse_clicked() {
  open -a Weather
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
