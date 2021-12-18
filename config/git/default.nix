{ ... }: {
  programs.git = {
    enable = true;
    userName = "nyarla";
    userEmail = "nyarla@kalaclista.com";
    aliases = {
      co = "checkout";
      ci = "commit";
      st = "status";
    };
    extraConfig = {
      color = { ui = true; };
      init = { defaultBranch = "main"; };
      core = {
        fileMode = false;
        preloadindex = true;
        fscache = true;
        autoCRLF = false;
        quotepath = false;
      };
    };
    ignores = import ./gitignore.nix;
  };
}
