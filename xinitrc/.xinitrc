#!/bin/sh
export LIBGL_ALWAYS_SOFTWARE=1

xset +fp /usr/share/fonts/local

xbindkeys

xrdb -merge ~/.Xresources

setxkbmap -option ctrl:nocaps
setxkbmap -layout "us,ru" -variant ",winkeys" -option "grp:ctrl_shift_toggle,grp_led:scroll"

feh --randomize --bg-fill ~/Pictures/Wallpapers/*

exec spectrwm
