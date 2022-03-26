{ pkgs, ... }: {
  imports = [
    ./config/app-container
    ./config/archivers
    ./config/backup
    ./config/browser
    ./config/chat
    ./config/cryptocurrency
    ./config/daw
    ./config/desktops
    ./config/development
    ./config/dunst
    ./config/git
    ./config/gsettings
    ./config/keychain
    #./config/labwc
    ./config/mlterm
    ./config/nix-ld
    ./config/openbox
    ./config/skk
    ./config/starship
    ./config/syncthing
    ./config/zsh
  ];
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
