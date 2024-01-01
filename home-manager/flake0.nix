{
  description = "Home-manager flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      system = "aarch64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
    in
    {
    
      nixosConfigurations.tunapi-0 = nixpkgs.lib.nixosSystem {
          specialArgs = {inherit inputs;};
          modules = [
            inputs.home-manager.nixosModules.default
          ];
        };

    };
}
