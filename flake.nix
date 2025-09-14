{
  description = " ... ";

  outputs = {
    self,
    nixpkgs,
    stylix,
    home-manager,
    pre-commit-hooks,
    nix-flatpak,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};

    myModules = builtins.attrValues (import ./modules);

    mkSystem = hname:
      nixpkgs.lib.nixosSystem {
        modules =
          [
            ./hosts/${hname}/default.nix
            nix-flatpak.nixosModules.nix-flatpak
            stylix.nixosModules.stylix
            home-manager.nixosModules.home-manager
            {
              home-manager.users.wug = {
                imports = [./home] ++ myModules;
              };

              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
              };

              home-manager.extraSpecialArgs = {
                inherit inputs;
              };
            }
          ]
          ++ myModules;

        specialArgs = {
          inherit inputs;
        };
      };

    forAllSystems = nixpkgs.lib.genAttrs [
      "x86_64-linux"
      "aarch64-linux"
    ];
  in {
    nixosConfigurations = {
      keven = mkSystem "keven";
      kevnet = mkSystem "kevnet";
    };

    checks = forAllSystems (system: let
      preCommit = pre-commit-hooks.lib.${system}.run {
        src = ./.;
        hooks = {
          deadnix.enable = true;
          nixfmt-rfc-style.enable = true;
        };
      };
    in {
      pre-commit-check = preCommit;
    });

    devShells = forAllSystems (system: let
      check = self.checks.${system}.pre-commit-check;
    in {
      default = pkgs.mkShell {
        shellHook = check.shellHook;
        buildInputs = check.enabledPackages;
      };
    });
  };

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
     anyrun.url = "github:anyrun-org/anyrun";
     ags.url = "github:Aylur/ags";
nix-flatpak.url = "github:gmodena/nix-flatpak/";
          niri.url = "github:sodiboo/niri-flake";
    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    spicetify-nix = {
      url = "github:Gerg-L/spicetify-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

   zen-browser = {
      url = "github:pfaj/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
