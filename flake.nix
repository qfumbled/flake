{
  description = "TODO";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    stylix = {
      url = "github:danth/stylix";
    };

    jovian = {
      url = "github:jovian-experiments/jovian-nixos/development";
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

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };

    lsfg-vk-flake = {
      url = "github:pabloaul/lsfg-vk-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    plasma-manager,
    lsfg-vk-flake,
    nix-flatpak,
    chaotic,
    lanzaboote,
    impermanence,
    stylix,
    ...
  }: let
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    commonModules = [
      impermanence.nixosModules.impermanence
      lanzaboote.nixosModules.lanzaboote
      chaotic.nixosModules.default
      nix-flatpak.nixosModules.nix-flatpak
      home-manager.nixosModules.home-manager
      {
        home-manager.extraSpecialArgs = {
          inherit inputs system;
        };
        home-manager.sharedModules = [
          plasma-manager.homeManagerModules.plasma-manager
        ];
      }
    ];
  in {
    nixosModules.lanzaboote = import lanzaboote;

    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/laptop
          stylix.nixosModules.stylix

          # Laptop-specific home-manager user config
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.monaco = import ./home/laptop;
          }
        ] ++ commonModules;
        pkgs = pkgs;
      };

      desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        modules = [
          ./hosts/desktop
          lsfg-vk-flake.nixosModules.default

          # Desktop-specific home-manager user config
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.monaco = import ./home/desktop;
          }
        ] ++ commonModules;
        pkgs = pkgs;
      };
    };
  };
}
