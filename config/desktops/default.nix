{ pkgs, ... }:
let
  xremap = pkgs.writeText "config.json" (builtins.toJSON {
    keymap = [{
      name = "prefix key";
      remap = {
        f15 = "super-a";
        f16 = "super-t";
      };
    }];
  });

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

    export LANG=ja_JP.UTF-8
    export LC_ALL=ja_JP.UTF-8
    export XDG_SESSION_TYPE=x11

    systemctl --user import-environment DISPLAY XAUTHORITY DBUS_SESSION_BUS_ADDRESS XDG_SESSION_ID
    systemctl --user start graphical-session.target

    dbus-update-activation-environment --systemd --all

    sxhkd -c ${sxhkdrc} &
    xsetroot -cursor_name left_ptr

    exec openbox-session
  '';
in {
  xdg.configFile."sx/sxrc".source = "${sxrc}";
  systemd.user.services.xremap = {
    Unit = { Desctiption = "xremap service"; };
    Install = { WantedBy = [ "default.target" ]; };
    Service = {
      Type = "simple";
      ExecStart = toString (pkgs.writeShellScript "xremap.sh" ''
        ${pkgs.xremap}/bin/xremap ${xremap} --device event0
      '');
    };
  };
}
