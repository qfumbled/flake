{
  description = "wug's nixos flake [2025]";

  inputs = {
    nixpkgs = {
      url = "github:NixOS/nixpkgs/nixos-unstable";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils = {
      url = "github:numtide/flake-utils";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence = {
      url = "github:nix-community/impermanence";
    };

    nix-flatpak = {
      url = "github:gmodena/nix-flatpak";
    };

    stylix = {
      url = "github:danth/stylix";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur = {
      url = "github:nix-community/NUR";
    };

    nixvim = {
      url = "github:qfumbled/nixvim";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    impermanence,
    nix-flatpak,
    stylix,
    spicetify-nix,
    nixvim,
    nur,
    firefox-addons,
    ...
  }: let
    username = "wug";
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config = {
        allowUnfree = true;
        allowUnfreePredicate = _: true;
      };
    };

    commonModules = [
      impermanence.nixosModules.impermanence
      nix-flatpak.nixosModules.nix-flatpak
      home-manager.nixosModules.home-manager
      stylix.nixosModules.stylix
      {
        home-manager.extraSpecialArgs = {
          inherit inputs system username;
        };
      }
    ];

    lib =
      nixpkgs.lib
      // home-manager.lib;

  in {
    nixosConfigurations = {
      magnus = nixpkgs.lib.nixosSystem {
        inherit system pkgs;

        modules =
          [
            ./hosts/magnus
            {
              home-manager.backupFileExtension = "bak";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} =
                import ./home/profiles/magnus.nix;
            }
          ]
          ++ commonModules;

        specialArgs = { inherit inputs system username; };
      };

      akatosh = nixpkgs.lib.nixosSystem {
        inherit system pkgs;

        modules =
          [
            ./hosts/akatosh
            {
              home-manager.backupFileExtension = "bak";
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.${username} =
                import ./home/profiles/akatosh.nix;
            }
          ]
          ++ commonModules;

        specialArgs = { inherit inputs system username; };
      };
    };
  };
}
