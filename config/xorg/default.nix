{ pkgs, ... }: {
  home.packages = with pkgs; [
    clipit
    hsetroot
    i3lock-fancy
    lxappearance
    maim
    mate.mate-system-monitor
    sxhkd
    wmctrl
    xdotool
    xremap
  ];
}
