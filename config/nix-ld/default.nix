{ pkgs, lib, ... }:
let
  packages = with pkgs; [
    # for standalone binary
    stdenv.cc.cc.lib
    stdenv.cc.libc
  ];
in {
  xdg.configFile."profile.d/nix-ld.sh" = {
    text = ''
      export NIX_LD_LIBRARY_PATH="$NIX_LD_LIBRARY_PATH''${NIX_LD_LIBRARY_PATH:+:}${
        lib.makeLibraryPath packages
      }"

      export NIX_LD_LIBRARY_PATH=$( echo $NIX_LD_LIBRARY_PATH | tr ':' "\n" | sort -u | tr "\n" ":" | sed 's/:$//' )
    '';
  };
}
