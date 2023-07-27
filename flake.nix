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

    betterfox = {
      url = "github:yokoffing/Betterfox";
      flake = false;
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
    , nix-vscode-extensions
    , hosts
    , betterfox
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
          config.allowUnfree = true;
          overlays = [
            nur.overlay
            nix-vscode-extensions.overlays.default
          ];
        };

        defaults = {
          imports = [
            impermanence.nixosModules.impermanence
            home-manager.nixosModules.home-manager
            hosts.nixosModule
            ./system/modules
            ./system/configs/shared
          ];

          home-manager = {
            useGlobalPkgs = true;
            useUserPackages = true;
            users.i1i1 = {
              imports = [
                ./home
                nixvim.homeManagerModules.nixvim
              ];

            };
            extraSpecialArgs = {
              inherit betterfox;
            };
          };
        };

        pc = {
          deployment.allowLocalDeployment = true;
          deployment.targetHost = null;

          imports = with nixos-hardware.nixosModules; [
            ./system/configs/pc.nix
            common-pc-ssd
            common-gpu-amd
            common-cpu-intel-cpu-only
          ];

          features.networking.wireguard.enable = true;
          features.networking.wireguard.keyCommand = [
            "rbw"
            "get"
            "--folder"
            "wireguard"
            "client2"
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
            ./system/configs/laptop.nix
            dell-xps-13-9310
            common-hidpi
          ];

          features.networking.wireguard.enable = true;
          features.networking.wireguard.keyCommand = [
            "rbw"
            "get"
            "--folder"
            "wireguard"
            "client0"
          ];

          networking.hostName = "laptop";
        };
      };
    };
}
