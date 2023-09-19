#!/bin/bash

# Apply wallpaper using wal
#wal -i 282738 -i ~/Wallpaper/Aesthetic2.png &&
#wal -i ~/Pictures/dragon.jpg &&

# Start picom
dunst &
picom --config ~/.config/picom/picom.conf &
xinput set-prop 13 358 1 & # set click with tap on touchpad
xinput set-prop 13 340 0.4 & # set sensivility
xinput set-prop 13 371 1 & # middle click
setxkbmap -layout us -variant colemak_dh -option caps:capslock &
numlockx &
#xrandr --output eDP-1 --mode 1920x1080 --rate 60 &
## to set the lock screen
xss-lock ~/.config/qtile/runbetterlockscreen.sh
