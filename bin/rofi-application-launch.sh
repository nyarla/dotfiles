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

applications() {
  cat <<EOF
# Browser
firefox
thunderbird
transmission-gtk

# Files
caja
engrampa
eom
atril
pluma

# Musics
qjackctl
bitwig-studio
carla

# Multimedia
pavucontrol
arandr
calibre
deadbeef

# Office
mate-calc
gucharmap
peek
com.github.philip-scott.spice-up
keepassxc
simple-scan

# VM
VirtualBox

# Terminal
mlterm

# Utils
dconf-editor
magnify
mullvad-gui
connman-gtk
Xnest

# Scripts
kindle
FLStudio
mp3tag
DAW
EOF
}

main() {
  local APPS="$(applications | grep -v "^#" | grep -v "^$" | sort | uniq)"
  local SEL="$(echo $APPS | tr ' ' "\n" | filter)"

  if test -x ~/local/dotfiles/launch/$SEL ; then
    exec ~/local/dotfiles/launch/$SEL
  fi

  if test -x /run/current-system/sw/bin/$SEL ; then
    exec /run/current-system/sw/bin/$SEL
  fi
}

main
