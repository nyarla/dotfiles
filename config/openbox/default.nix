{ pkgs, lib, ... }: {
  xdg.configFile."openbox/autostart".source = "${(with pkgs;
    (import ./autostart.nix) { inherit fetchurl writeShellScript; })}";
  xdg.configFile."openbox/menu.xml".text = (import ./menu.nix) { };
  xdg.configFile."openbox/environment".text = ''
    GTK2_RC_FILES=$HOME/.gtkrc-2.0
    LANG=ja_JP.UTF_8
    LC_ALL=ja_JP.UTF-8
  '';
  xdg.configFile."openbox/rc.xml".text = (import ./rc.nix) { inherit lib; };
}
