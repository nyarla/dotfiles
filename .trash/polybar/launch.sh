#!/bin/sh

pkill polybar
while pkill -u $uid -x polybar >/dev/null; do sleep 1; done

case "${PATH}" in
*:/etc/nixos/scripts:*) ;;
*) export PATH=/etc/nixos/scripts:$PATH
esac


