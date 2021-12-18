{
  description = "My NixOS dotfiles";
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/master";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs = inputs: {
    homeConfigurations = {
      nyarla = inputs.home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        homeDirectory = "/home/nyarla";
        username = "nyarla";
        configuration.imports = [ ./home.nix ];
      };
    };
  };
}
