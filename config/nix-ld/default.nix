{ config, pkgs, lib, ... }: {
  xdg.configFile."profile.d/nix-ld.sh" = {
    text = ''
      export NIX_LD_LIBRARY_PATH="$NIX_LD_LIBRARY_PATH''${NIX_LD_LIBRARY_PATH:+:}${
        lib.makeLibraryPath config.home.packages
      }"

      export NIX_LD_LIBRARY_PATH=$( echo $NIX_LD_LIBRARY_PATH | tr ':' "\n" | sort | uniq | tr "\n" ":" | sed 's/:$//' )
    '';
  };
}
