{ rustPlatform, fetchgit, lib, pkgconfig, wayland, egl-wayland, wayland-scanner
, wayland-protocols, patchelf }:
rustPlatform.buildRustPackage rec {
  pname = "wayout";
  version = "1.0.0";

  src = fetchgit {
    url = "https://git.sr.ht/~shinyzenith/wayout";
    sha256 = "16qsxc742hwiyhhi4dxd1brkdqhl1jirmcxy67znp4halabgva8s";
  };

  buildInputs = [ wayland wayland-scanner wayland-protocols ];
  nativeBuildInputs = [ pkgconfig ];

  cargoSha256 = "sha256-91ivkZUMdgHxCT+dJG/uPUZf/3dHPqnR90gH7tOEFMg=";

  postFixup = ''
    patchelf --add-rpath ${wayland}/lib $out/bin/wayout
    patchelf --add-needed libwayland-client.so $out/bin/wayout
  '';
}
