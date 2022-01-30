{ pkgs, ... }: {
  home.packages = with pkgs; [
    bitwarden
    firefox-bin
    google-chrome
    keepassxc
    libsecret
    pinentry-gnome
    thunderbird-bin
  ];
}
