{ pkgs, config, lib, ... }: {
  home.packages = with pkgs; [ droidcam discord slack tdesktop ];
}