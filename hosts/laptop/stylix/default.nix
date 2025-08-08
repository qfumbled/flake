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
          type = lib.types.enum [
            "dark"
            "light"
          ];
        };
        themeName = lib.mkOption {
          default = "far";
          type = lib.types.enum [
            "far"
            "test"
          ];
        };
      };
    };
  };

    stylix = {
      enable = true;

      # Placeholder image (literally doesn't matter)
      # image = ../../../wallpapers/accordion.png;

      base16Scheme = ./themes/${cfg.themeName}.yaml;
      polarity = cfg.polarity;

      # Cursor config is currently disabled
      # cursor = {
      #   name = "phinger-cursors-light";
      #   package = pkgs.phinger-cursors;
      #   size = 24;
      # };

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
    };
  };
}
