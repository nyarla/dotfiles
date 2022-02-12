{ pkgs, ... }: {
  home.packages = with pkgs; [ electrum electrum-ltc msr-tools xmrig goreman ];
}
