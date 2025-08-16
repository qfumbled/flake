{ config, pkgs, ... }:

{
  programs.home-manager.enable = true;

  imports = [
    ./core
    ./programs
     ./style
    ./wm
    ./terminals
    ./shells
    ./services
  ];
}
