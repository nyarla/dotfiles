{ pkgs, ... }: {
  home.packages = (with pkgs.mate; [
    atril
    caja
    caja-extensions
    engrampa
    eom
    mate-polkit
    pluma
  ]) ++ (with pkgs; [
    gnome3.ghex
    gnome3.gnome-disk-utility
    gnome3.gnome-font-viewer
  ]);

  xdg.configFile."profile.d/caja.sh" = {
    text = ''
      export CAJA_EXTENSION_DIRS=$CAJA_EXTENSION_DIRS''${CAJA_EXTENSION_DIRS:+:}''${HOME}/.nix-profile/lib/caja/extensions-2.0
    '';
  };
}
