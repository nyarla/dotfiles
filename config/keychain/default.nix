{ ... }: {
  programs.keychain = {
    enable = true;
    keys = [ "id_ed25519" ];
    extraFlags = [ "--nogui" "--quiet" ];
    enableZshIntegration = true;
    enableBashIntegration = true;
  };
}
