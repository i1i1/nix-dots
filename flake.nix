{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:pta2002/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
    impermanence.url = "github:nix-community/impermanence";
    nixos-hardware.url = "github:nixos/nixos-hardware";
    nur.url = "github:nix-community/NUR";

    # For CI checks
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };
  };

  outputs =
    { self
    , nixpkgs
    , flake-utils
    , home-manager
    , nixvim
    , impermanence
    , nixos-hardware
    , nur
    , pre-commit-hooks
    , ...
    }:
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
    # Plenty of ci checks
    flake-utils.lib.eachDefaultSystem
      (system: {
        checks.pre-commit-check = pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            actionlint.enable = true;
            deadnix.enable = true;
            nixpkgs-fmt.enable = true;
            statix.enable = true;
          };
        };
        devShells.default = nixpkgs.legacyPackages.${system}.mkShell {
          inherit (self.checks.${system}.pre-commit-check) shellHook;
        };
      })

    // {
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
