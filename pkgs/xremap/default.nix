{ rustPlatform, fetchurl, xorg, lib, pkgconfig }:
rustPlatform.buildRustPackage rec {
  pname = "xremap";
  version = "v0.3.0";

  buildInputs = with xorg; [ libX11 ];
  nativeBuildInputs = [ pkgconfig ];

  src = fetchurl {
    url =
      "https://github.com/k0kubun/xremap/archive/refs/tags/${version}.tar.gz";
    sha256 = "1d39cbq1c0vkmgbciss4wxi7py8wrr7y3ligvr24b8m790y4zwan";
  };

  cargoSha256 = "sha256-JHQWGpumjKp/cWZp9H/u7Ay1zai+J+mdh8uadViDad4=";

  buildFeatures = [ "x11" ];
}
