#!/usr/bin/env bash

cd $HOME/Pictures

xdpyinfo -ext XINERAMA | sed '/^  head #/!d;s///' |
while IFS=' :x@,' read i w h x y; do
  gm import -window root -crop ${w}x$h+$x+$y ScreenShot_$(date +%Y-%m-%dT%H:%M:%S)-head-$i.png
done

notify-send -u low ScreenShot 'done!' 
