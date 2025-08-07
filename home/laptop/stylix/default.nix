{
  pkgs,
  config,
  lib,
  ...
}: {
  options = {
    theme = lib.mkOption {
      default = "far";
      type = lib.types.enum [
        "far"
      ];
    };

    wallpaper = lib.mkOption {
      default = ../../../wallpapers/mountain.jpg;
      type = lib.types.path;
    };

    # Or polarity
    themeVariant = lib.mkOption {
      default = "dark";
      type = lib.types.enum [
        "dark"
        "light"
      ];
    };
  };

  config = {
    stylix = {
      enable = true;

      # Placeholder (literally doesn't matter)
      image = config.wallpaper;

      base16Scheme = ./themes/${config.theme}.yaml;
      polarity = config.themeVariant;

      targets = {
        hyprland.enable = false;
        neovim.enable = false;
        nixvim.enable = false;
        spicetify.enable = false;
        fzf.enable = false;
        tmux.enable = false;
        hyprlock.enable = false;
        gtk.extraCss = with config.lib.stylix.colors; ''
          @define-color accent_color #${base0D};
          @define-color accent_bg_color #${base0D};
        '';
      };

      fonts = {
        sizes.terminal = 10;
        monospace = {
          name = "RobotoMono Nerd Font";
          package = pkgs.nerd-fonts.roboto-mono;
        };
        sansSerif = {
          name = "rubik";
          package = pkgs.rubik;
        };
      };
    };

    qt = {
      enable = true;
    };
  };
}
