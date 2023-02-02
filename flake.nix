{
  description = "System config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-22.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };


  outputs = { nixpkgs, home-manager, ... }:
    let
      system = "x86_64-linux";

      pkgs = import nixpkgs {
        inherit system;
        config = { allowUnfree = true; };
      };

      lib = nixpkgs.lib;

    in
    {
      nixosConfigurations = {
        i1i1 = lib.nixosSystem {
          inherit system;

          modules = [
            ./system/configuration.nix
            # home-manager.nixosModules.home-manager
            # {
            #   home-manager = {
            #     useGlobalPkgs = true;
            #   };
            # }
          ];
        };
      };
      homeConfigurations.i1i1 = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        imports = [ ./user/i1i1/home.nix ];
      };
    };
}

