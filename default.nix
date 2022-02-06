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

  ethminer = (super.ethminer.override {
    stdenv = super.llvmPackages_13.stdenv;
    cudatoolkit = super.cudatoolkit_11_5;
  }).overrideAttrs (old: rec {
    version = "1.9.2";
    src = super.fetchFromGitHub {
      owner = "danieleftodi";
      repo = "ethminer";
      rev = "59e063c57d44b3de5393b81f92d89b76d86107a3";
      sha256 = "1ra1jlc8s3r12qzqkbqzf8646cbj219mqdms04wdzaya2af444h6";
      fetchSubmodules = true;
    };
    postPatch = ''
      sed -i 's|jsoncpp_static|jsoncpp|' libpoolprotocols/CMakeLists.txt
      sed -i 's|-Wall|-Wall -Ofast -funroll-loops|g' cmake/EthCompilerSettings.cmake
    '';
  });

  nsfminer = (require ./pkgs/nsfminer {
    stdenv = super.llvmPackage_13.stdenv;
    cudatoolkit = super.cudatoolkit_11_5;
  }).overrideAttrs (old: rec {
    postPatch = old.preConfigure + ''
      sed -i 's/set(CMAKE_CXX_FLAGS "''${CMAKE_CXX_FLAGS} -stdlib=libstdc++ -fcolor-diagnostics -Qunused-arguments")//' cmake/EthCompilerSettings.cmake
      sed -i 's|-Wall|-Wall -Ofast -funroll-loops|g' cmake/EthCompilerSettings.cmake
    '';
  });
}
