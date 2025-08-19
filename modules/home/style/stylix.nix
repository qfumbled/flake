{ config, pkgs, ... }:  # added pkgs if you use it inside
{
  stylix.targets = {
    neovim.enable = false;
    fzf.enable = false;
    tmux.enable = false;
    nixcord.enable = false;
    waybar.enable = false;
    fuzzel.enable = false;
    mako.enable = false;
    sway.enable = false;
    monospace = {
      name = "Iosevka Nerd Font Mono";
      package = pkgs.nerd-fonts.iosevka;
    };

    sansSerif = {
      name = "IBM Plex Sans";
      package = pkgs.ibm-plex;
    };
  };

  # firefox.profileNames = ["wug"];

  gtk.extraCss = with config.lib.stylix.colors; ''
    @define-color accent_color #${base0D};
    @define-color accent_bg_color #${base0D};

    * {
      border-radius: 25;
    }
  '';
}
