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
    nur.url = "github:nix-community/NUR";
  };

  outputs = { nixpkgs, home-manager, nixvim, impermanence, nixos-hardware, nur, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
        overlays = [ nur.overlay ];
      };
      nixosSystem = { hardwareModules }: nixpkgs.lib.nixosSystem {
        inherit system pkgs;

        modules = hardwareModules ++ [
          impermanence.nixosModules.impermanence
          # nur.nixosModules.nur
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
        "i1i1-pc" = nixosSystem {
          hardwareModules = with nixos-hardware.nixosModules; [
            { networking.hostName = "i1i1-pc"; }
            ./hardware/pc.nix
            common-pc-ssd
            common-gpu-amd
            common-cpu-intel-cpu-only
          ];
        };
        "i1i1-laptop" = nixosSystem {
          hardwareModules = [
            { networking.hostName = "i1i1-laptop"; }
            ./hardware/laptop.nix
            nixos-hardware.nixosModules.dell-xps-13-9310
          ];
        };
      };
    };
}
