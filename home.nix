{ pkgs, ... }: {
  imports = [
    ./config/backup
    ./config/desktops
    ./config/dunst
    ./config/git
    ./config/keychain
    ./config/mlterm
    ./config/openbox
    ./config/skk
    ./config/starship
    ./config/syncthing
    ./config/zsh
  ];
  nixpkgs.overlays = [ (import ./.) ];
  home.packages = with pkgs; [
    bup-up
    gyazo
    restic
    restic-run
    screenshot
    wine-run
  ];
}
