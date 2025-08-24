{ config, pkgs, lib, ... }:

{
  imports = [
    inputs.stylix.homeModules.stylix
    ../../modules/home
  ];

  meadow = {
    default = {
      shell = [
        "fish"
        #"zsh"
      ];
      wm       = "labwc";
      terminal = "foot";
    };
     
    browser = {
      firefox.enable = true;
    };

    programs = {
      yamlfmt.enable = true;
      yamllint.enable = true;
      zellij.enable = true;
      lazygit.enable = true;
      obsidian.enable = false;
    };

    services = {
      waybar.enable = true;
      mako.enable   = true;
      fuzzel.enable = true;
    };
  };

  home = {
    packages = with pkgs; [
      wdisplays
      distrobox  # just in case, makes it less hell
    ];
  };
}
