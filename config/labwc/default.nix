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
    wmname
    wayout
  ];

  xdg.configFile."labwc/autostart".source = toString (with pkgs;
    (import ./autostart.nix) { inherit fetchurl writeShellScript; });

  xdg.configFile."labwc/menu.xml".text = (import ./menu.nix) { };

  xdg.configFile."labwc/environment".text = ''
    XDG_SESSION_TYPE=wayland

    GTK2_RC_FILES=$HOME/.gtkrc-2.0
    XCURSOR_PATH=$HOME/.nix-profile/share/icons:$HOME/.icons/default
    XCURSOR_THEME=capitaine-cursors-white

    LANG=ja_JP.UTF_8
    LC_ALL=ja_JP.UTF-8

    XKB_DEFAULT_LAYOUT=us

    GDK_BACKEND=wayland
    GTK_CSD=0
    GTK_THEME=Victory

    CLUTTER_BACKEND=wayland

    QT_QPA_PLATFORMTHEME=qt5ct
    QT_QPA_PLATFORM=wayland-egl
    QT_WAYLAND_DISABLE_WINDOWDECORATION=1

    SDL_VIDEODRIVER=wayland
    _JAVA_AWT_WM_NONREPARENTING=1

    MOZ_ENABLE_WAYLAND=1
    MOZ_WEBRENDER=0
  '';
}
