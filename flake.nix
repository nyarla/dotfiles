{
  description = "My NixOS dotfiles";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    dotnix.url = "git+file:///etc/nixos/external/dotnix";
    dotnix.inputs.nixpkgs.follows = "nixpkgs";

    wayland.url =
      "github:nix-community/nixpkgs-wayland/832a0ed28dbb0aa50f2dc2a1a85abfb11ed56c1d";
    wayland.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs: {
    homeConfigurations = {
      nyarla = inputs.home-manager.lib.homeManagerConfiguration rec {
        system = "x86_64-linux";
        homeDirectory = "/home/nyarla";
        username = "nyarla";
        configuration = {
          imports = [ ./home.nix ];
          nixpkgs.overlays =
            [ inputs.dotnix.overlay inputs.wayland.overlay (import ./.) ];
          systemd.user.startServices = true;
          home.packages = [ inputs.home-manager.defaultPackage.${system} ];
        };
      };
    };
  };
}
