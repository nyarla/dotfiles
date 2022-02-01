{ pkgs, ... }: {
  xdg.configFile."labwc/autostart".source = "${(with pkgs;
    (import ./autostart.nix) { inherit fetchurl writeShellScript; })}";

  xdg.configFile."labwc/menu.xml".text = (import ../openbox/menu.nix) { };

  xdg.configFile."labwc/environment".text = ''
    GTK2_RC_FILES=$HOME/.gtkrc-2.0
    XCURSOR_THEME=capitaine-cursors-white

    LANG=ja_JP.UTF_8
    LC_ALL=ja_JP.UTF-8

    XKB_DEFAULT_LAYOUT=us

    CLUTTER_BACKEND=wayland
    GDK_BACKEND=wayland
    QT_QPA_PLATFORM=wayland
    SDL_VIDEODRIVER=wayland
    _JAVA_AWT_WM_NONREPARENTING=1
  '';
  xdg.configFile."electron-flags.conf".text = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
  '';

  xdg.configFile."electron12-flags.conf".text = ''
    --enable-features=UseOzonePlatform
    --ozone-platform=wayland
  '';
}
