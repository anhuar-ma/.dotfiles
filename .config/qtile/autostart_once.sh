#!/bin/bash

# Apply wallpaper using wal
#wal -i 282738 -i ~/Wallpaper/Aesthetic2.png &&
wal -i ~/Pictures/astronaut.jpg &&

# Start picom
dunst &
picom --config ~/.config/picom/picom.conf &
xinput set-prop ELAN0521:01\ 04F3:31B1\ Touchpad  358 1 & # set click with tap on touchpad
xinput set-prop ELAN0521:01\ 04F3:31B1\ Touchpad  340 0.4 & # set sensivility
xinput set-prop ELAN0521:01\ 04F3:31B1\ Touchpad  371 1 & # middle click
setxkbmap -layout us -variant colemak_dh -option caps:capslock &
numlockx &
systemctl --user start plasma-powerdevil.service & 
#xrandr --output eDP-1 --mode 1920x1080 --rate 60 &
## to set the lock screen
xss-lock ~/.config/qtile/runbetterlockscreen.sh &
#disable beep sound
xset b off &
