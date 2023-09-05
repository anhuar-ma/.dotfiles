#!/bin/bash

# Apply wallpaper using wal
#wal -i 282738 -i ~/Wallpaper/Aesthetic2.png &&
wal -i ~/Pictures/planetspurple.png &&

# Start picom
picom --config ~/.config/picom/picom.conf &
xinput set-prop 13 347 1 &
xinput set-prop 13 329 0.4 & 
setxkbmap -layout us -variant colemak_dh -option caps:capslock &
xrandr --output eDP-1 --mode 1920x1080 --rate 60 &
