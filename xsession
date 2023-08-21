#!/usr/bin/env bash

autorandr -c

/usr/bin/setxkbmap -option 'caps:ctrl_modifier'
/usr/bin/xcape -e 'Caps_Lock=Escape' -t 100

# lock
xautolock -time 3 -detectsleep -corners +00- -locker "i3lock-fancy --pixelate" -notify 30 -notifier "notify-send -u critical -t 10000 -- 'locking in 30 seconds'" &

# notifications
dunst &

# background
feh --image-bg black --bg-fill ~/Pictures/bg

# screen annotations
gromit-mpx &

# compositor
compton &

# polybar
polybar -r &

# chrome & google chat
google-chrome --restore-last-session &
google-chrome --app=http://chat.google.com &

exec $HOME/.local/bin/xmonad
