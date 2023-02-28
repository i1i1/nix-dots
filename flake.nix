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
    nixos-hardware.url = "github:nixos/nixos-hardware";
  };

  outputs = { nixpkgs, home-manager, nixvim, impermanence, nixos-hardware, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };
      nixosSystem = { hardwareModules }: nixpkgs.lib.nixosSystem {
        inherit system pkgs;

        modules = hardwareModules ++ [
          impermanence.nixosModules.impermanence
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              users.i1i1 = import ./home;
              extraSpecialArgs = {
                inherit nixvim;
              };
            };
          }
        ];
      };
    in
    {
      nixosConfigurations = {
        "i1i1" = nixosSystem {
          hardwareModules = with nixos-hardware.nixosModules; [
            ./hardware/pc.nix
            common-pc-ssd
            common-gpu-amd
            common-cpu-intel-cpu-only
          ];
        };
        "i1i1@laptop" = nixosSystem {
          hardwareModules = [
            ./hardware/laptop.nix
            nixos-hardware.nixosModules.dell-xps-13-9310
          ];
        };
      };
    };
}
