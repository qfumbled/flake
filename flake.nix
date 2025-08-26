{
  description = "Wug's NixOS System";

  outputs =
    {
      self,
      nixpkgs,
      nur,
      firefox-addons,
      flake-utils,
      flake-parts,
      hm,
      impermanence,
      nix-flatpak,
      stylix,
      spicetify-nix,
      nixvim,
      pre-commit-hooks,
      ...
    }@inputs:
    let
      outputs = self;

      mkLib = pkgs: pkgs.lib.extend (final: prev: (import ./lib final pkgs) // hm.lib);

      packages = nixpkgs.legacyPackages;

      mkSystem = {
        system ? "x86_64-linux",
        systemConfig,
        userConfigs,
        username ? "wug",
        lib ? mkLib packages.${system},
        zone ? "Europe/Budapest"
      }: let
        pkgs = import nixpkgs { inherit system; config.allowUnfree = true; };
      in
        nixpkgs.lib.nixosSystem {
          inherit system pkgs;

          specialArgs = { inherit inputs self lib username zone; };

          modules = [
            { nixpkgs.hostPlatform = system; }
            systemConfig
            ./modules/nixos
            {

              home-manager.sharedModules = [ ./modules/home ];
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.extraSpecialArgs = { inherit inputs self lib username zone; };
              home-manager.users.${username}.imports = [ userConfigs ];
            }
          ];
        };

      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

      checks = forAllSystems (system: {
        pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            deadnix.enable = true;
            nixfmt-rfc-style.enable = true;
          };
        };
      });

      devShells = forAllSystems (system: {
        default = packages.${system}.mkShell {
          inherit (checks.${system}.pre-commit-check) shellHook;
          buildInputs = checks.${system}.pre-commit-check.enabledPackages;
        };
      });

    in {
      nixosConfigurations = {
        magnus = mkSystem {
          systemConfig = ./hosts/magnus;
          userConfigs = ./home/profiles/magnus.nix;
          username = "wug";
        };

        akatosh = mkSystem {
          systemConfig = ./hosts/akatosh;
          userConfigs = ./home/profiles/akatosh.nix;
          username = "wug";
        };
      };

      formatter.x86_64-linux = packages.x86_64-linux.nixfmt-rfc-style;
      devShells = devShells;
      checks = checks;
    };

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

    hm = {
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

    pre-commit-hooks = {
      url = "github:cachix/git-hooks.nix";
    };
  };
}
