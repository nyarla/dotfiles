{ pkgs, ... }: {
  imports = [
    ./config/desktops
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
  home.packages = with pkgs; [ bup-up wine-run gyazo screenshot ];
}
