#!/usr/bin/env bash

nm-applet &
/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &
setxkbmap -option ctrl:nocaps &
xset r rate 300 40 &
"$HOME"/.screenlayout/dual-screen.sh &
sleep 2
nitrogen --restore &
# xrandr -r 60 &
