{ pkgs, ... }: {
  home.packages = with pkgs; [
    # cloud toolchain
    google-cloud-sdk

    # container toolchain
    linuxkit
    act

    # compiler
    binutils
    clang-tools
    gdb
    pkgconfig
    stdenv.cc

    # go
    go
    goimports

    # nim
    nim
    nimlsp

    # rust
    rustup

    # node.js
    nodejs_latest
    python3
    yarn

    # perl
    perl
    perlPackages.Appcpanminus
    perlPackages.PerlTidy
    nix-generate-from-cpan

    # java
    openjdk

    # nix
    nixfmt
    rnix-lsp

    # editor
    neovim
    neovim-remote
    editorconfig-core-c

    # vcs
    mercurial
    subversion
    cvs

    # website
    hugo

    # misc
    mecab
    openssl
  ];
}
