#!/usr/bin/zsh

xcape -e 'Control_L=Escape;Caps_Lock=Escape'

feh --bg-scale ~/Pictures/wp/wp1.jpg

kitty tmux &
slack &
google-chrome &
spotify &

polybar -r main 2>&1 | tee -a /tmp/polybar.log & disown

exec xmonad
