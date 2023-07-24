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
      url = "github:nix-community/nixvim";
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

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-utils.follows = "flake-utils";
    };

    hosts.url = "github:StevenBlack/hosts";
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
    , nix-vscode-extensions
    , hosts
    , ...
    }:
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
      colmena = {
        meta.nixpkgs = import nixpkgs {
          system = "x86_64-linux";
          config = { allowUnfree = true; };
          overlays = [
            nur.overlay
            nix-vscode-extensions.overlays.default
          ];
        };

        defaults = {
          imports = [
            impermanence.nixosModules.impermanence
            ./configuration.nix
            home-manager.nixosModules.home-manager
            hosts.nixosModule
          ];

          networking.stevenBlackHosts.enable = true;

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.i1i1 = {
              imports = [
                ./home
                nixvim.homeManagerModules.nixvim
              ];
            };
          };
        };

        pc = {
          deployment.allowLocalDeployment = true;
          deployment.targetHost = null;

          imports = with nixos-hardware.nixosModules; [
            ./hardware/pc.nix
            common-pc-ssd
            common-gpu-amd
            common-cpu-intel-cpu-only
          ];

          networking.hostName = "pc";
          home-manager.users.i1i1.features = {
            gui.games = true;
            gui.misc = true;
          };
        };

        laptop = {
          deployment.allowLocalDeployment = true;
          deployment.targetHost = null;

          imports = with nixos-hardware.nixosModules; [
            ./hardware/laptop.nix
            dell-xps-13-9310
            common-hidpi
          ];

          networking.hostName = "laptop";
        };
      };
    };
}
