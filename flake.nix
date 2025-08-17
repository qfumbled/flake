{
  description = "wug's nixos flake [2025]";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    impermanence.url = "github:nix-community/impermanence";
    nix-flatpak.url = "github:gmodena/nix-flatpak";
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";
    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nur.url = "github:nix-community/NUR";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    nixvimm.url = "github:qfumbled/nixvim";

    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    astal = {
      url = "github:aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    swayfx = {
      url = "github:WillPower3309/swayfx";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    nixpkgs,
    home-manager,
    impermanence,
    nix-flatpak,
    sops-nix,
    stylix,
    spicetify-nix,
    nixvimm,
    nur,
    zen-browser,
    ags,
    astal,
    swayfx,
    ...
  }: let
    username = "wug";
    system = "x86_64-linux";

    pkgs = import nixpkgs {
      inherit system;
      config.allowUnfree = true;
    };

    commonModules = [
      impermanence.nixosModules.impermanence
      nix-flatpak.nixosModules.nix-flatpak
      home-manager.nixosModules.home-manager
      stylix.nixosModules.stylix
      {
        home-manager.extraSpecialArgs = { inherit inputs system; };
      }
    ];

    lib =
      nixpkgs.lib
      // home-manager.lib
      // (import ./lib { inherit (nixpkgs) lib; });

  in {
    nixosConfigurations.magnus = nixpkgs.lib.nixosSystem {
      inherit system pkgs;

      modules =
        [
          ./hosts/magnus
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.${username} =
              import ./home/profiles/magnus.nix;
          }
        ]
        ++ commonModules;

      specialArgs = { inherit inputs system; };
    };
  };
}
