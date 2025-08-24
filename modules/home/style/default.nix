{ lib, inputs, pkgs, config, ... }:

let
  inherit (config.meadow.style) theme polarity;
  inherit (lib) mkOption types;
in
{
  imports = [
    inputs.stylix.homeManager.stylix
  ];

  options.meadow.style = {
    wallpaper = mkOption {
      type = types.path;
      default = "";
    };
    theme = mkOption {
      type = types.str;
      default = "";
    };
    polarity = mkOption {
      type = types.str;
      default = "dark";
    };
  };

  config = {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.papirus-icon-theme;
      };
    };

    stylix = {
      enable       = true;
      base16Scheme = "${inputs.self}/home/shared/colors/${theme}.yaml";
      image        = "${inputs.self}/home/shared/wallpapers/${theme}.jpg";
      polarity     = "${polarity}";
      cursor = {
        name    = "phinger-cursors-light";
        package = pkgs.phinger-cursors;
        size    = 24;
      };
      opacity = {
        popups   = 1.0;
        terminal = 1.0;
      };

      targets = {
        firefox.enable   = false;
        fzf.enable       = false;
        hyprland.enable  = false;
        hyprlock.enable  = false;
        lazygit.enable   = false;
        waybar.enable    = false;
        mako.enable      = false;
        nixcord.enable   = false;
        sway.enable      = false;
      };

      fonts = {
        sizes.terminal     = 10;
        sizes.applications = 10;
        sizes.desktop      = 10;
        monospace = {
          name    = "RobotoMono Nerd Font Propo";
          package = pkgs.nerd-fonts.roboto-mono;
        };
        sansSerif = {
          name    = "Rubik";
          package = pkgs.rubik;
        };
      };
    };
  };
}

