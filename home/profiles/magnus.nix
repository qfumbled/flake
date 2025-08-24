{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/home
  ];

  meadow = {
    default = {
      shell = [
        "fish"
       # "mksh" soon i guess.. 
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
      # soon zellij.enable = true;
      # soon lazygit.enable = true;
    };

    services = {
      waybar.enable = true;
      mako.enable   = true;
    };
  };

  home = {
    packages = with pkgs; [
      wdisplays
      distrobox  # just in case, makes it less hell
    ];
  };
}
