{ pkgs, ... }: {
  imports = [
    ./config/archivers
    ./config/backup
    ./config/browser
    ./config/desktops
    ./config/development
    ./config/dunst
    ./config/git
    ./config/gsettings
    ./config/keychain
    ./config/mlterm
    ./config/openbox
    ./config/skk
    ./config/starship
    ./config/syncthing
    ./config/zsh
  ];
  nixpkgs.overlays = [ (import ./.) ];
  nixpkgs.config.allowUnfree = true;
  home.packages = with pkgs; [
    bup-up
    gyazo
    restic
    restic-run
    screenshot
    wine-run
  ];
}
