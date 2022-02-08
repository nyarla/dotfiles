{ pkgs, lib, ... }: {
  home.packages = with pkgs;
    [
      clipit
      hsetroot
      i3lock-fancy
      jq
      lxappearance
      lxqt.lxqt-config
      lxqt.lxqt-panel
      maim
      mate.mate-system-monitor
      mlterm
      obconf
      openbox
      perl
      sxhkd
      wmctrl
      xdotool
      xremap
    ] ++ lxqt.preRequisitePackages;

  xdg.configFile = {
    "openbox/autostart".source = "${(with pkgs;
      (import ./autostart.nix) { inherit fetchurl writeShellScript; })}";

    "openbox/menu.xml".text = (import ./menu.nix) { };

    "openbox/environment".text = ''
      GTK2_RC_FILES=$HOME/.gtkrc-2.0
      LANG=ja_JP.UTF_8
      LC_ALL=ja_JP.UTF-8
    '';

    "openbox/rc.xml".text = (import ./rc.nix) { inherit lib; };
  };
}
