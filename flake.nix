{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    anyrun.url = "github:anyrun-org/anyrun"; 
    crane.url = "github:ipetkov/crane";
    nix-flatpak.url = "github:gmodena/nix-flatpak/";  
    lanzaboote.url = "github:nix-community/lanzaboote";
    systems.url = "github:nix-systems/default-linux";
    flake-compat.url = "github:edolstra/flake-compat";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    jovian = {
      url = "github:jovian-experiments/jovian-nixos/development";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    lsfg-vk-flake = {
      url = "github:pabloaul/lsfg-vk-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Uncomment if needed:
    # arkenfox.url = "github:dwarfmaster/arkenfox-nixos";
  };

  outputs = { self, nixpkgs, home-manager, plasma-manager, jovian, lsfg-vk-flake, nix-flatpak, lanzaboote, ... }: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/laptop
          lanzaboote.nixosModules.lanzaboote  # This should work now with the correct URL
          nix-flatpak.nixosModules.nix-flatpak  # Corrected this part
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dulish = import ./home/laptop;
            home-manager.sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
          }
        ];
      };

      desktop = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/desktop
          lanzaboote.nixosModules.lanzaboote  
          lsfg-vk-flake.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak  # Corrected here as well
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dulish = import ./home/desktop;
            home-manager.sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
          }
        ];
      };

      deck = nixpkgs.lib.nixosSystem {
        modules = [
          ./hosts/deck
          lsfg-vk-flake.nixosModules.default
          jovian.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.dulish = import ./home/deck;
            home-manager.sharedModules = [plasma-manager.homeManagerModules.plasma-manager];
          }
        ];
        specialArgs = { inherit jovian; };
      };
    };
  };
}
