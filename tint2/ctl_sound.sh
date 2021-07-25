#!/bin/ksh

if [ "i$1" = "i-t" ]; then
   sndioctl -q output.mute=!
   shift
fi

STATUS=$(sndioctl -n output.mute)
if [ "$STATUS" = "1" ]; then
  echo "0%"
else
   SOUND_LEVEL=$(sndioctl -n output.level) 
   if [ $1 ]; then
      SOUND_LEVEL=$(echo "$SOUND_LEVEL + $1 / 100 " | bc -l)
      if [ $SOUND_LEVEL -lt 0 ]; then
          SOUND_LEVEL=0
      fi
      if [ $SOUND_LEVEL -gt 1 ]; then
          SOUND_LEVEL=1
      fi
      sndioctl -q output.level=$SOUND_LEVEL
   fi
   SOUND_VALUE=$(echo "$SOUND_LEVEL * 100 " | bc | sed 's/^\./0\./')
   echo "Vol: $(printf '%.0f' $SOUND_VALUE)%"
fi
