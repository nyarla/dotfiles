#!/bin/sh

for cmd in sxhkd polybar; do
  pkill $cmd
  while pkill -u $(id -u) -x $cmd >/dev/null; do sleep 1; done
done

sxhkd -c ~/local/dotfiles/jwm/sxhkdrc &
polybar -c /home/nyarla/local/dotfiles/polybar/NyXPS15.ini main &
