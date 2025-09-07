{
  description = "Wug's NixOS System";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    impermanence.url = "github:nix-community/impermanence";
    nix-flatpak.url = "github:gmodena/nix-flatpak";

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
    vicinae.url = "github:vicinaehq/vicinae";

    neovim = {
      url = "github:qfumbled/nvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    systems.url = "github:nix-systems/default-linux";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";
    pre-commit-hooks.url = "github:cachix/git-hooks.nix";

    agenix = {
      url = "github:ryantm/agenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "hm";
        systems.follows = "systems";
      };
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = { self, nixpkgs, hm, ... }@inputs:
  let
    packages = nixpkgs.legacyPackages;

    mkLib = pkgs:
      pkgs.lib.extend (final: prev:
        (import ./lib final pkgs) // hm.lib
      );

    mkSystem =
      { system ? "x86_64-linux"
      , systemConfig
      , userConfigs
      , username ? "wug"
      , lib ? mkLib packages.${system}
      }:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      nixpkgs.lib.nixosSystem {
        inherit system pkgs;
        specialArgs = { inherit self lib username inputs; };

        modules = [
          { nixpkgs.hostPlatform = system; }

          systemConfig

           hm.nixosModules.home-manager
 #         inputs.impermanence.nixosModules.impermanence
  #        inputs.nix-flatpak.nixosModules.nix-flatpak
           inputs.stylix.nixosModules.stylix
    #      inputs.chaotic.nixosModules.default
          (import ./system { inherit pkgs lib username; })

          {
            home-manager = {
              sharedModules = [ ./modules/home ];
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit self lib username inputs; };
              users.${username}.imports = [ userConfigs ];
            };
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

    checks = forAllSystems (system:
      let
        preCommit = inputs.pre-commit-hooks.lib.${system}.run {
          src = ./.;
          hooks = {
            deadnix.enable = true;
            nixfmt-rfc-style.enable = true;
          };
        };
      in {
        pre-commit-check = preCommit;
      });

    devShells = forAllSystems (system:
      let check = checks.${system}.pre-commit-check;
      in {
        default = packages.${system}.mkShell {
          shellHook = check.shellHook;
          buildInputs = check.enabledPackages;
        };
      });
  in
  {
    nixosConfigurations = {
      grovetender = mkSystem {
     # fix   systemConfig = ./hosts;
        systemConfig = ./hosts/grovetender;
        userConfigs = ./home/profiles/grovetender.nix;
        username = "wug";
      };

      aurelionite = mkSystem {
        systemConfig = ./hosts/aurelionite;
        userConfigs = ./home/profiles/aurelionite.nix;
        username = "wug";
      };
    };

    formatter.x86_64-linux = packages.x86_64-linux.nixfmt-rfc-style;
    devShells = devShells;
    checks = checks;

    flake-parts = inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];
      imports = [ ./home/profiles ./hosts ];
      perSystem = { config, pkgs, ... }: {};
    };
  };
}
