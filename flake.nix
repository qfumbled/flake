{
  description = "nixos";

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
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

  inputs = {
    # Core Nixpkgs
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Tools and Utilities
    flake-compat.url = "github:edolstra/flake-compat";
    flake-utils.url = "github:numtide/flake-utils";
    flake-parts.url = "github:hercules-ci/flake-parts";

    # Home Manager
    hm = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Additional Tools
    zen-browser.url = "github:pfaj/zen-browser-flake";
    stylix.url = "github:danth/stylix";
    agenix.url = "github:ryantm/agenix";
    mynixpkgs.url = "github:linuxmobile/mynixpkgs";

    # Gaming
    nix-gaming.url = "github:fufexan/nix-gaming";
    chaotic.url = "github:chaotic-cx/nyx/nyxpkgs-unstable";

    # Other
    anyrun.url = "github:anyrun-org/anyrun";
    niri.url = "github:sodiboo/niri-flake";
  };
}
