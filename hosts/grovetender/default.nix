{ config, pkgs, ... }:

{
  imports =
    [ 
      ./hardware.nix
      ../../modules/nixos
    ];
}
