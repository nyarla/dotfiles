{ pkgs, ... }: {
  imports = [ ./waybar.nix ];

  home.packages = with pkgs; [
    # system monitoring
    mate.mate-system-monitor

    # clipboard
    clipman
    wl-clipboard

    # screenshot
    grim
    slurp

    # compositor
    labwc
    waybar

    # sway utils
    swaybg
    swayidle
    swaylock-effects

    # uitls
    wev
    wlr-randr
    ydotool
  ];

  xdg.configFile."labwc/autostart".source = "${(with pkgs;
    (import ./autostart.nix) { inherit fetchurl writeShellScript; })}";

  xdg.configFile."labwc/menu.xml".text = (import ./menu.nix) { };

  xdg.configFile."labwc/environment".text = ''
    GTK2_RC_FILES=$HOME/.gtkrc-2.0

    XCURSOR_PATH=/run/current-system/sw/share/icons:$HOME/.icons/default
    XCURSOR_THEME=capitaine-cursors-white

    LANG=ja_JP.UTF_8
    LC_ALL=ja_JP.UTF-8

    XKB_DEFAULT_LAYOUT=us

    GDK_BACKEND=wayland
    GTK_CSD=0
    GTK_THEME=Victory

    QT_QPA_PLATFORM=xcb
    CLUTTER_BACKEND=wayland

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
