{ fetchurl, writeShellScript }:
let
  automount = uuid: path: ''
    if test -e "/dev/disk/by-uuid/${uuid}" ; then
      if test ! -d ${path} ; then
        gio mount -d ${uuid} ${path} &
      fi
    fi
  '';

  wallpaper = fetchurl {
    url =
      "https://raw.githubusercontent.com/NixOS/nixos-artwork/master/wallpapers/nix-wallpaper-simple-light-gray.png";
    sha256 = "0i6d0xv1nzrv7na9hjrgzl3jrwn81vnprnq2pxyznlxbjcgkjnk2";
  };
in writeShellScript "autostart" ''
  run() {
    if type "''${1}" >/dev/null 2>&1 ; then
      $@ &
    fi
  }

  config="$HOME/.config/gtk-3.0/settings.ini"
  if test -e $config ; then
    schema="org.gnome.desktop.interface"
    gsettings set $schema gtk-theme "$(grep 'gtk-theme-name' "$config" | cut -d= -f2)"
    gsettings set $schema icon-theme "$(grep 'gtk-icon-theme-name' "$config" | cut -d= -f2)"
    gsettings set $schema cursor-theme "$(grep 'gtk-cursor-theme-name' "$config" | cut -d= -f2)"
    gsettings set $schema font-name "$(grep 'gtk-font-name' "$config" | cut -d= -f2)"
  fi

  export XDG_DATA_DIRS=/run/current-system/sw/share:''${XDG_DATA_DIRS}

  run fcitx
  run ydotoold
  run wl-paste -t text --watch clipman store
  run swayidle -w timeout 600 'swaylock' timeout 300 'wayout --off HDMI-A-1' resume 'wayout --on HDMI-A-1' before-sleep 'swaylock'

  run swaybg -i ${wallpaper} -m fit
  run waybar

  if test "$(hostname)" == "nixos"; then
    ${automount "05b4746c-9eed-4228-b306-922a9ef6ac4e" "/run/media/nyarla/data"}
    ${automount "470d2a2f-bdea-49a2-8e9b-242e4f3e1381" "/run/media/nyarla/src"}

    run calibre --start-in-tray
  fi
''
