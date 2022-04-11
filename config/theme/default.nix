{ pkgs, lib, ... }: {
  home.packages = with pkgs; [
    capitaine-cursors
    flatery-icon-theme
    gnome.adwaita-icon-theme
    gnome.gnome-themes-extra
    gtk-engine-murrine
    gtk_engines
    hicolor-icon-theme
    libsForQt5.qt5ct
    libsForQt5.qtstyleplugins
    victory-gtk-theme
  ];
}
