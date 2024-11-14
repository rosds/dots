#!/usr/bin/env bash

autorandr -c

/opt/zscaler/bin/ZSTray &

# lock
xautolock -time 3 -detectsleep -corners +00- -locker "i3lock -i ~/Pictures/bg -t" -notify 30 -notifier "notify-send -u critical -t 10000 -- 'locking in 30 seconds'" &

# chrome & google chat
google-chrome --restore-last-session &

exec $HOME/.local/bin/xmonad
