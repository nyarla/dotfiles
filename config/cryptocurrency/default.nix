{ pkgs, ... }: {
  home.packages = with pkgs; [
    electrum
    electrum-ltc
    ethminer
    msr-tools
    nsfminer
    xmrig
  ];
}
