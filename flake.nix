{
  description = "TODO";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };

    chaotic = {
      url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
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

    lsfg-vk-flake = {
      url = "github:pabloaul/lsfg-vk-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    self,
    nixpkgs,
    home-manager,
    plasma-manager,
    jovian,
    lsfg-vk-flake,
    nix-flatpak,
    chaotic,
    lanzaboote,
    impermanence,
    zen-browser,
    rust-overlay,
    ...
  }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [inputs.rust-overlay.overlays.default];
    };
  in {
    nixosModules.lanzaboote = import lanzaboote;

    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/laptop
          impermanence.nixosModules.impermanence
          chaotic.nixosModules.default
          lanzaboote.nixosModules.lanzaboote
          nix-flatpak.nixosModules.nix-flatpak
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.monaco = import ./home/laptop;
            home-manager.extraSpecialArgs = {
              inherit inputs system;
            };
            home-manager.sharedModules = [
              plasma-manager.homeManagerModules.plasma-manager
            ];
          }
        ];
        pkgs = pkgs;
      };

      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/desktop
          impermanence.nixosModules.impermanence
          lanzaboote.nixosModules.lanzaboote
          chaotic.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak
          lsfg-vk-flake.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.monaco = import ./home/desktop;
            home-manager.extraSpecialArgs = {
              inherit inputs system;
            };
            home-manager.sharedModules = [
              plasma-manager.homeManagerModules.plasma-manager
            ];
          }
        ];
        pkgs = pkgs;
      };

      deck = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/deck
          impermanence.nixosModules.impermanence
          chaotic.nixosModules.default
          lsfg-vk-flake.nixosModules.default
          jovian.nixosModules.default
          nix-flatpak.nixosModules.nix-flatpak
          lanzaboote.nixosModules.lanzaboote
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.monaco = import ./home/deck;
            home-manager.extraSpecialArgs = {
              inherit inputs system;
            };
            home-manager.sharedModules = [
              plasma-manager.homeManagerModules.plasma-manager
            ];
          }
        ];
        specialArgs = {
          inherit jovian;
        };
        pkgs = pkgs;
      };
    };

    devShells.${system} = import ./lib/shells.nix {
      inherit pkgs;
    };

    packages = import ./lib/systems.nix {inherit self system;};
  };
}
