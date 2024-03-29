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

  run hsetroot -fill ${wallpaper}
  run ~/.nix-profile/libexec/openbox-xdg-autostart GNONE MATE LXQt

  if test "$(hostname)" == "nixos"; then
    ${automount "05b4746c-9eed-4228-b306-922a9ef6ac4e" "/run/media/nyarla/data"}
    ${automount "470d2a2f-bdea-49a2-8e9b-242e4f3e1381" "/run/media/nyarla/src"}
    run calibre --start-in-tray
  fi
''
