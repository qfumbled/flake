{
  description = "NixOS configuration for grovetender with home-manager, nixvim, and other flakes";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-utils.url = "github:numtide/flake-utils";
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-flatpak.url = "github:gmodena/nix-flatpak";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote.url = "github:nix-community/lanzaboote";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    anyrun.url = "github:anyrun-org/anyrun";
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-compat.url = "github:edolstra/flake-compat";
  };

  outputs = inputs@{ self, nixpkgs, home-manager, flake-parts, nix-flatpak, chaotic, niri, lanzaboote, nixvim, nur, ... }: let
    system = "x86_64-linux";
    username = "wieners";
    host = "grovetender";
    profile = "grovetender";

    mkSystem = gpu: name: modules: nixpkgs.lib.nixosSystem {
      inherit system;
      specialArgs = {
        inherit inputs username host profile gpu;
      };
      modules = modules ++ [
        ./modules/drivers/${gpu}.nix
      ];
    };
  in {
    nixosConfigurations = {
      grovetender = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = {
          inherit (nixpkgs) lib inputs overlays;
          gpu = "intel";
        };
        modules = [
          ./hosts/grovetender
          ./modules/drivers/intel.nix
          nixvim.nixosModules.nixvim
          home-manager.nixosModules.home-manager
          nix-flatpak.nixosModules.nix-flatpak
          chaotic.nixosModules.default
          niri.nixosModules.niri
          lanzaboote.nixosModules.lanzaboote
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.wieners = import ./home/profiles/grovetender.nix;
          }
        ];
      };

      amd = mkSystem "amd" "amd" [ ./profiles/amd ];
      nvidia = mkSystem "nvidia" "nvidia" [ ./profiles/nvidia ];
      nvidia-prime = mkSystem "nvidia" "nvidia-prime" [ ./profiles/nvidia-prime ];
      intel = mkSystem "intel" "intel" [ ./profiles/intel ];
    };
  };
}
