self: super:
let require = path: args: super.callPackage (import path) args;
in {
  bup-up = require ./pkgs/bup-up { };
  gyazo = require ./pkgs/gyazo { };
  screenshot = require ./pkgs/screenshot { };
  skk-dicts-xl = require ./pkgs/skk-dicts-xl { };
  terminfo-mlterm-256color = require ./pkgs/terminfo-mlterm-256color { };
  wine-run = require ./pkgs/wine-run { };
}
