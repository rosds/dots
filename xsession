#!/usr/bin/env bash

autorandr -c

/usr/bin/setxkbmap -option 'caps:ctrl_modifier'
/usr/bin/xcape -e 'Caps_Lock=Escape' -t 100

# lock
xautolock -time 3 -detectsleep -corners +00- -locker "i3lock-fancy --pixelate" -notify 30 -notifier "notify-send -u critical -t 10000 -- 'locking in 30 seconds'" &

# notifications
dunst &

# background
feh --image-bg black --bg-scale ~/Pictures/eldenring.png

# screen annotations
# gromit-mpx &

# compositor
compton -c &

# polybar
polybar -r &

# apps
google-chrome --restore-last-session &

exec $HOME/.local/bin/xmonad
