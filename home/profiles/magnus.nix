{ config, pkgs, lib, ... }:

{
  imports = [
    ../../modules/home
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "Morewaita";
      package = pkgs.morewaita-icon-theme;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  home = {
    packages = with pkgs; [
      teeworlds   # very important to work
      distrobox
    ];
  };
}
