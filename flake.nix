{
  description = "nixos";

  inputs = {
    systems.url = "github:nix-systems/default-linux";

    flake-compat.url = "github:edolstra/flake-compat";

    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

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

  outputs = inputs: let
    # Make sure inputs are passed correctly
    inherit (inputs) nixpkgs hm zen-browser stylix agenix nix-gaming anyrun niri;

  in inputs.flake-parts.lib.mkFlake {
    inherit inputs;
    systems = ["x86_64-linux"];

    # Import paths for profiles and system config
    imports = [
      ./home/profiles    # Ensure this path is correctly specified
      ./hosts
      ./pkgs
    ];

    perSystem = { config, pkgs, ... }: {
      # Dev shell setup
      devShells = {
        default = pkgs.mkShell {
          packages = [ pkgs.alejandra pkgs.git pkgs.nix ];
          name = "nixland";
          DIRENV_LOG_FORMAT = "";
        };
      };

      # Nix Formatter
      formatter = pkgs.alejandra;

      # Define nixosConfigurations for the nixawestic host
      nixosConfigurations = {
        nixawestic = pkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./hosts/nixawestic/default.nix  # Referencing the host system config
            ./home/profiles/default.nix    # Referencing user profiles
          ];
          configuration = config;  # Specify any additional options if necessary
        };
      };
    };
  };
}
