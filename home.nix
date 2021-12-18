{ pkgs, ... }: {
  imports = [
    ./config/git
    ./config/mlterm
    ./config/openbox
    ./config/skk
    ./config/starship
    ./config/syncthing
  ];
  nixpkgs.overlays = [ (import ./.) ];
  home.packages = with pkgs; [ bup-up wine-run gyazo screenshot ];
}
