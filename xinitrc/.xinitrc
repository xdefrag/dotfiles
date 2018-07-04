#!/bin/sh
export LIBGL_ALWAYS_SOFTWARE=1

setxkbmap -option ctrl:nocaps
setxkbmap -layout "us,ru" -variant ",winkeys" -option "grp:ctrl_shift_toggle,grp_led:scroll"
xrdb -merge ~/.Xresources

xscreensaver -no-splash &
feh --randomize --bg-fill ~/Pictures/Wallpapers/*

exec spectrwm
