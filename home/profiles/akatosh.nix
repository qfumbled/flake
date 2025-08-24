{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/home
  ];

  meadow = {
    services = {
      waybar.enable = true;
    };
  };

  home = {
    packages = with pkgs; [
      wdisplays
      distrobox  # just in case, makes it less hell
    ];
  };
}
