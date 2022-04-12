self: super:
let require = path: args: super.callPackage (import path) args;
in rec {
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
    installPhase = (builtins.replaceStrings [ "bitwig-studio.desktop" ]
      [ "com.bitwig.BitwigStudio.desktop" ] old.installPhase);
  });

  calibre = (super.calibre.override {
    python3Packages = super.python3Packages.overrideScope
      (orig: old: { # remove after #168071 is merged
        apsw = old.apsw.overrideAttrs (old: {
          version = "3.38.1-r1";
          sha256 = "sha256-pbb6wCu1T1mPlgoydB1Y1AKv+kToGkdVUjiom2vTqf4=";
          checkInputs = [ ];
        });
      });
  }).overrideAttrs (old: rec {
    buildInputs = [ super.python3Packages.pycrypto ] ++ old.buildInputs;
  });

  firefox-bin-unwrapped =
    super.firefox-bin-unwrapped.override { systemLocale = "ja_JP"; };

  labwc = (super.labwc.override { inherit (self) wlroots; }).overrideAttrs
    (old: rec {
      src = super.fetchFromGitHub {
        owner = "labwc";
        repo = "labwc";
        rev = "401b282772094bf7423df9865949a18f8a9c4a92";
        sha256 = "sha256-IowLcVrMlrQbtqiK/xdyPCXayA3sQvDroiXbNXIOo3A=";
      };
    });

  wlroots = super.wlroots.overrideAttrs (old: rec {
    buildInputs = old.buildInputs ++ [ super.egl-wayland ];
    src = super.fetchFromGitHub {
      owner = "git-bruh";
      repo = "wlroots-eglstreams";
      rev = "e9bccfeee7a82db1e89c750a37cb98400e118761";
      sha256 = "sha256-oZswRC7+eLDu9JmmmV33o36grQ1QjtBl6SZhEvHvVsQ=";
    };
  });
}
