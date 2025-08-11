{
  description = "nixos";

  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    systems = ["x86_64-linux"];

    # Import paths for profiles and system config
    imports = [
      ./home/profiles  # Ensure this path is correctly specified
      ./hosts
      ./pkgs
    ];

    perSystem = { system, config, pkgs, ... }: {
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
        nixawestic = pkgs.nixosSystem {
          system = "x86_64-linux";  # Specify the system architecture
          modules = [
            ./hosts/nixawestic/default.nix  # Host-specific NixOS config
            ./home/profiles/default.nix    # User-specific Home Manager config
            # You can add more modules here if needed, like services or other configurations
          ];

          # Optionally, set additional configuration options here
          configuration = config;
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
