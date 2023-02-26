{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:pta2002/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
  };

  outputs = { nixpkgs, home-manager, nixvim, impermanence, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      lib = nixpkgs.lib;

    in
    {
      nixosConfigurations =
        let
          system = hardware:
            lib.nixosSystem {
              inherit system pkgs;

              modules = [
                impermanence.nixosModules.impermanence
                ./configuration.nix
                hardware
                home-manager.nixosModules.home-manager
                { home-manager = { useGlobalPkgs = true; }; }
              ];
            };
        in
        {
          "i1i1" = system ./hardware/pc.nix;
          "i1i1@laptop" = system ./hardware/laptop.nix;
        };
      homeConfigurations.i1i1 = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;

        modules = [
          ./user/i1i1/home.nix
          nixvim.homeManagerModules.nixvim
          impermanence.nixosModules.home-manager.impermanence
        ];
      };
    };
}
