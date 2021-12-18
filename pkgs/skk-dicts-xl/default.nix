{ stdenv, lib, fetchurl, skktools, libiconv }:
let
  dicts = lib.strings.concatStringsSep " + "
    (lib.lists.forEach (import ./skk.nix) (x:
      fetchurl {
        name = x.name;
        url = x.url;
        sha256 = x.sha256;
      }));

in stdenv.mkDerivation rec {
  pname = "skk-dicts-xl";
  version = "2021-11-11";
  dontUnpack = true;

  nativeBuildInputs = [ skktools ];

  installPhase = ''
    mkdir -p $out/share/skk/

    echo ';; -*- mode: fundamental; coding: euc-jp -*-' >$out/share/skk/SkK-JISYO.XL
    skkdic-expr2 ${dicts} >>$out/share/skk/SkK-JISYO.XL 

    iconv -c -f EUC-JISX0213 -t utf8 < $out/share/skk/SkK-JISYO.XL >$out/share/skk/SKK-JISYO.XL.utf8
    sed -i 's|coding: euc-jp|coding: utf8|' $out/share/skk/SKK-JISYO.XL.utf8
  '';
}
