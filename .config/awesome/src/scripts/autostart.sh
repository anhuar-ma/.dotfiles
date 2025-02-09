!/bin/bash

# Apply wallpaper using wal
#wal -i 282738 -i ~/Wallpaper/Aesthetic2.png &&
#wal -i ~/Pictures/astronaut.jpg &&

# Start picom
#dunst &
#notify-send "test" &
picom --config ~/.config/picom/picom.conf &
#xinput set-prop ELAN0521:01\ 04F3:31B1\ Touchpad  358 1 & # set click with tap on touchpad
#xinput set-prop ELAN0521:01\ 04F3:31B1\ Touchpad  340 0.4 & # set sensivility
xinput set-prop ELAN0521:01\ 04F3:31B1\ Touchpad libinput\ Tapping\ Enabled 1 &
xinput set-prop ELAN0521:01\ 04F3:31B1\ Touchpad libinput\ Accel\ Speed 0.4 &
#xinput set-prop ELAN0521:01\ 04F3:31B1\ Touchpad  371 1 & # middle click
setxkbmap -layout us -variant colemak_dh -option caps:capslock &
#setxkbmap -layout my_colemak_dh
numlockx &
#systemctl --user start plasma-powerdevil.service &
#xrandr --output eDP-1 --mode 1920x1080 --rate 60 &
## to set the lock screen
#xss-lock ~/.config/qtile/runbetterlockscreen.sh &
#disable beep sound
xset b off &
xfce4-screensaver &
#xfce4-power-manager &
#xfce4-power-manager --quit &
xfce4-power-manager &
#qbittorrent &
#imwheel --kill && imwheel &
#xmodmap -e "keycode 135 = ISO_Level3_Shift" &
#otd-daemon &
# qbittorrent &
#xrandr --output HDMI-0 --off && xrandr --output eDP-1-1 --primary --mode 1920x1080 --dpi 92 --pos 0x360 --rotate normal --output DP-1 --off --output DP-2 --off --output HDMI-0 --mode 2560x1440 --dpi 108 --pos 1920x0 --rotate normal &
#xrandr --output eDP-1-1 --dpi 92 --pos 0x360 --output HDMI-0 --dpi108 --pos 1920x0 &
#sudo rmmod r816 && sudo modprobe r8169 &
pactl set-sink-volume @DEFAULT_SINK@ 18% &
# start emacs in the background
emacs --daemon &
# NEW WAY TO START THE SCREEN layout
#/home/anhuar/.screenlayout/algoLayout.sh
