 {
  inputs,
  pkgs,
  ...
}:
{
  imports = [
    ../../modules/home
  ];

  meadow = {
    browser = {
      firefox.enable = true;
    };
    programs = {
      obsidian.enable = false;
      yamlfmt.enable = true;
      yamllint.enable = true;
      spicetify.enable = true;
      zellij.enable = true;
    };

    services = {
      waybar.enable = true;
      fuzzel.enable = true;
      mako.enable = true;
      swaync.enable = false;      
      vicinae.enable = false;
    };

    default = {
      shell = [
        "fish"
        "zsh"
      ];
      wm = "labwc";
      terminal = "foot";
    };
  };

  # Specific packages for this home-manager host config
  home = {
    packages = with pkgs; [
      android-tools
      lunar-client
      scrcpy
      stremio
      equicord
      wdisplays
      yazi
      # affine
    ];
  };
}
