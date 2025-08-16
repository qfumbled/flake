{
  description = "wug's nixos flake [2025]";

  inputs = {
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";

    impermanence.url = "github:nix-community/impermanence";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
 spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

     anyrun = {
      url = "github:anyrun-org/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nvim-config.url = "github:kewin-y/nvim-kewin";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    stylix.url = "github:danth/stylix";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";

    # Niri WM
    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    impermanence,
    nix-flatpak,
    niri,
    sops-nix,
    stylix,
    spicetify-nix,
    anyrun,
    nvim-config,
    nur,
    zen-browser,
    ...
  }: let
    username = "wug";
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
      overlays = [
        niri.overlays.niri
      ];
    };

    commonModules = [
      impermanence.nixosModules.impermanence
      nix-flatpak.nixosModules.nix-flatpak
      home-manager.nixosModules.home-manager
      stylix.nixosModules.stylix
      {
        home-manager.extraSpecialArgs = {
          inherit inputs system;
        };
      }
    ];

    # Merge Nixpkgs, Home Manager, and your custom lib
    lib = nixpkgs.lib // home-manager.lib // (import ./lib { inherit (nixpkgs) lib; });

  in {
    nixosConfigurations.magnus = nixpkgs.lib.nixosSystem {
      inherit system pkgs;

      modules =
        [
          ./hosts/magnus
         # niri.nixosModules.niri
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} = import ./home/profiles/magnus.nix;
          }
        ] ++ commonModules;

      specialArgs = {
        inherit inputs system;
      };
    };

    packages = {
      default = pkgs.hello; # Example default package
    };
  };
}
