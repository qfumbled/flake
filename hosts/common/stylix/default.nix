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
          type = lib.types.bool;
          default = false;
          description = "Enable the stylix theme";
        };
        polarity = lib.mkOption {
          type = lib.types.enum ["dark" "light"];
          default = "dark";
          description = "Theme polarity (dark or light)";
        };
        themeName = lib.mkOption {
          type = lib.types.enum ["far" "test"];
          default = "far";
          description = "Stylix theme name";
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    opt.stylix = {
      enable = true;

      # You can uncomment and adjust this path if you want wallpaper support
      # image = ../../../wallpapers/accordion.png;

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
