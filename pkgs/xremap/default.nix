{ rustPlatform, fetchurl, xorg, lib, pkgconfig }:
rustPlatform.buildRustPackage rec {
  pname = "xremap";
  version = "v0.2.4";

  buildInputs = with xorg; [ libX11 ];
  nativeBuildInputs = [ pkgconfig ];

  src = fetchurl {
    url =
      "https://github.com/k0kubun/xremap/archive/refs/tags/${version}.tar.gz";
    sha256 = "1rwarcipv6vqikps6b9v76l2qzr9q7w7dx4iz4vjsmjacjkpnn6x";
  };

  cargoSha256 = "sha256-6JX5R9nRB/rpYV21EjZHSl+/nnXLbmke/VjZyAkFWaA=";

  buildFeatures = [ "x11" ];
}
