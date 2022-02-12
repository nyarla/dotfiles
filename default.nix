self: super:
let require = path: args: super.callPackage (import path) args;
in {
  # additional packages
  JUCE = require ./pkgs/JUCE { };
  bup-up = require ./pkgs/bup-up { };
  dexed = require ./pkgs/dexed { };
  gyazo = require ./pkgs/gyazo { };
  restic-run = require ./pkgs/restic-run { };
  screenshot = require ./pkgs/screenshot { };
  skk-dicts-xl = require ./pkgs/skk-dicts-xl { };
  terminfo-mlterm-256color = require ./pkgs/terminfo-mlterm-256color { };
  wcwidth-cjk = require ./pkgs/wcwidth-cjk { };
  wine-run = require ./pkgs/wine-run { };
  xremap = require ./pkgs/xremap { };

  # override packages
  bitwig-studio3 = super.bitwig-studio3.overrideAttrs (old: rec {
    version = "3.3.11";
    src = super.fetchurl {
      url =
        "https://downloads.bitwig.com/stable/${version}/${old.pname}-${version}.deb";
      sha256 = "137i7zqazc2kj40rg6fl6sbkz7kjbkhzdd7550fabl6cz1a20pvh";

    };
    installPhase = (builtins.replaceStrings [ "bitwig-studio.desktop" ]
      [ "com.bitwig.BitwigStudio.desktop" ] old.installPhase);
  });

  zrythm = require "${super.fetchurl {
    url =
      "https://raw.githubusercontent.com/NixOS/nixpkgs/c27afb62d45d1c12053404c24fdf579935b7ca1e/pkgs/applications/audio/zrythm/default.nix";
    sha256 = "05mmcmsks3vj46alvlc0mf5ji8l011zgrijwri54a0s9vb9sg3zg";
  }}" { };
}
