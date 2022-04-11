{ pkgs, lib, ... }:
let
  sxhkdrc = pkgs.writeText "sxhkdrc" ''
    super + l
      xset dpms force off

    super + alt + l
      mlterm
  '';

  sxrc = pkgs.writeShellScript "xinitrc" ''
    for rc in $(ls /etc/profile.d); do
      . /etc/profile.d/$rc
    done

    for rc in $(ls $HOME/.config/profile.d); do
      . $HOME/.config/profile.d/$rc
    done

    systemctl --user import-environment DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS XDG_SESSION_ID
    systemctl --user start graphical-session.target

    dbus-update-activation-environment --systemd --all

    sxhkd -c ${sxhkdrc} &
    xsetroot -cursor_name left_ptr

    exec openbox-session
  '';

in {
  imports = [ ../xorg ];

  home.packages = with pkgs;
    [ jq lxqt.lxqt-config lxqt.lxqt-panel obconf openbox perl wmctrl ]
    ++ lxqt.preRequisitePackages;

  xdg.configFile = {
    # openbox
    "openbox/autostart".source = toString (with pkgs;
      (import ./autostart.nix) { inherit fetchurl writeShellScript; });

    "openbox/menu.xml".text = (import ./menu.nix) { };

    "openbox/environment".source = toString (pkgs.writeScript "environment" ''
      export GTK2_RC_FILES=$HOME/.gtkrc-2.0
      export LANG=ja_JP.UTF_8
      export LC_ALL=ja_JP.UTF-8
      export QT_QPA_PLATFORMTHEME=qt5ct
      export XDG_SESSION_TYPE=x11
    '');

    "openbox/rc.xml".text = (import ./rc.nix) { inherit lib; };

    # sx
    "sx/sxrc".source = "${sxrc}";

  };
}
