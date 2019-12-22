#!/usr/bin/env sh

filter() {
  rofi  -dmenu          \
        -show run       \
        -matching fuzzy \
        -lines 10       \
        -width 3840     \
        -location 1     \
        -dpi 192        \
        -color-window "#191919,#F9F9F9,#666666" \
        -color-normal "#191919,#FFFFFF,#333333,#CCFF00,#000000" \
        -color-urgent "#191919,#FF0000,#333333,#CC0000,#FFFFFF" \
        -color-active "#191919,#FFFFFF,#333333,#00CCFF,#000000" 
}

main() {
  local APPS="$(ls /run/current-system/sw/bin | grep -v "^#" | grep -v "^$" | sort | uniq)"
  local SEL="$(echo $APPS | tr ' ' "\n" | filter)"

  if type $SEL; then
    exec $SEL
  fi
}

main
