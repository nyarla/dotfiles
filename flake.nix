{
  description = "My NixOS dotfiles";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    dotnix.url = "git+file:///etc/nixos/external/dotnix";
    dotnix.inputs.nixpkgs.follows = "nixpkgs";

    wayland.url = "github:nix-community/nixpkgs-wayland/master";
    wayland.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = { nixpkgs, home-manager, ... }@inputs: {
    homeConfigurations = {
      nyarla = home-manager.lib.homeManagerConfiguration rec {
        username = "nyarla";
        homeDirectory = "/home/${username}";

        system = "x86_64-linux";
        pkgs = nixpkgs.legacyPackages.${system};
        stateVersion = "22.11";

        configuration = rec {
          imports = [ ./home.nix ];
          nixpkgs.overlays = with inputs; [ dotnix.overlay (import ./.) ];

          systemd.user.startServices = true;
          home.packages = [ home-manager.defaultPackage.${system} ];
        };

      };
    };
  };
}
