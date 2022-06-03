#!/usr/bin/env bash

autorandr -c

/usr/bin/setxkbmap -option 'caps:ctrl_modifier'
/usr/bin/xcape -e 'Caps_Lock=Escape' -t 100

feh --image-bg black --bg-scale ~/Pictures/eldenring.png

polybar -r &

exec $HOME/.local/bin/xmonad
