{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.opt.stylix;
in {
  options = {
    opt = {
      stylix = {
        enable = lib.mkOption {
          default = false;
          type = lib.types.bool;
          description = "Enable the stylix theme";
        };
        polarity = lib.mkOption {
          default = "dark";
          type = lib.types.enum ["dark" "light"];
          description = "Theme polarity (dark or light)";
        };
        themeName = lib.mkOption {
          default = "far";
          type = lib.types.enum ["far" "test"];
          description = "Stylix theme name";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    opt.stylix = {
      enable = true;

      #  image = ../../../wallpapers/accordion.png;

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
    };
  };
}
