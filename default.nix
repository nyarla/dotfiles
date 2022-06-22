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
  wayout = require ./pkgs/wayout { };
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
    installPhase = builtins.replaceStrings [ "bitwig-studio.desktop" ]
      [ "com.bitwig.BitwigStudio.desktop" ] old.installPhase;
  });

  calibre = super.calibre.overrideAttrs (old: rec {
    buildInputs = old.buildInputs ++ [ super.python3Packages.pycrypto ];
  });

  firefox-bin-unwrapped =
    super.firefox-bin-unwrapped.override { systemLocale = "ja_JP"; };
}
