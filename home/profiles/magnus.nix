{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/home
  ];

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  home = {
    packages = with pkgs; [
      distrobox # just in case makes it less hell
    ];
  };
}
