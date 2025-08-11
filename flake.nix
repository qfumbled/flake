{
  description = "nixos";

  inputs = {
    systems.url = "github:nix-systems/default-linux";

    flake-compat.url = "github:edolstra/flake-compat";

    flake-utils.url = "github:numtide/flake-utils";

    flake-parts.url = "github:hercules-ci/flake-parts";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # rest of inputs, alphabetical order
    agenix = {
      url = "github:ryantm/agenix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "hm";
      inputs.systems.follows = "systems";
    };

    anyrun.url = "github:anyrun-org/anyrun";

    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote.url = "github:nix-community/lanzaboote";

    mynixpkgs.url = "github:linuxmobile/mynixpkgs";

    niri = {
      url = "github:sodiboo/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-index-db = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };

    stylix = {
      url = "github:danth/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:pfaj/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs: {
    # Use flake-parts correctly to define the systems
    systems = ["x86_64-linux"];

    # Imports
    imports = [
      ./home/profiles
      ./hosts
      ./pkgs
    ];

    # Define the per-system configurations
    nixosConfigurations = {
      nixawestic = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/nixawestic/default.nix  # Host system config
          ./home/profiles/default.nix    # User profile config
        ];
        configuration = { config, pkgs, ... }: {
          # Additional configuration options can go here
        };
      };
    };

    # Dev Shell
    devShells = {
      default = inputs.nixpkgs.mkShell {
        packages = [ inputs.nixpkgs.alejandra inputs.nixpkgs.git inputs.nixpkgs.nix ];
        name = "nixland";
        DIRENV_LOG_FORMAT = "";
      };
    };

    # Home Manager integration
    homeConfigurations = {
      nixawestic = inputs.hm.lib.homeManagerConfiguration {
        configuration = ./home/profiles/default.nix;
        pkgs = inputs.nixpkgs;
      };
    };
  };
}
