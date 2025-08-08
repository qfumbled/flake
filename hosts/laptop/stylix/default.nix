{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.theme.stylix;
in {
  options = {
    theme = {
      stylix = {
        polarity = lib.mkOption {
          default = "dark";
          type = lib.types.enum ["dark" "light"];
          description = "Color polarity for the theme";
        };
        themeName = lib.mkOption {
          default = "far";
          type = lib.types.enum ["far" "test"];
          description = "Name of the theme to use";
        };
      };
    };
  };

  config = {
    environment.systemPackages = with pkgs; [
      # Add any packages here if needed, e.g. fonts, cursors
    ];

    theme.stylix = {
      enable = true;

      base16Scheme = ./themes/${cfg.themeName}.yaml;
      polarity = cfg.polarity;

      fonts = {
        sizes = {
          terminal = 10;
          applications = 10;
          desktop = 10;
        };
        monospace = {
          name = "RobotoMono Nerd Font Propo";
          package = pkgs.nerd-fonts.roboto-mono;
        };
        sansSerif = {
          name = "Rubik";
          package = pkgs.rubik;
        };
      };

      # Uncomment and configure cursor if needed
      # cursor = {
      #   name = "phinger-cursors-light";
      #   package = pkgs.phinger-cursors;
      #   size = 24;
      # };
    };
  };
}
