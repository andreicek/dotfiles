#!/bin/sh
if [ "$1" = "full" ]; then
    grim - | swappy -f -
else
    grim -g "$(slurp)" - | swappy -f -
fi
