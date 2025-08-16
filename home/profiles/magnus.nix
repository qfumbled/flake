{ config, pkgs, ... }:

{
  imports = [
    ../../modules/home
  ];

  gtk = {
    enable = true;
    iconTheme = {
      name = "morewaita";
      package = pkgs.morewaita-icon-theme;
    };
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  programs.home-manager.enable = true;

  # Specific packages for this home-manager host config
  home.packages = with pkgs; [
    alacritty
    anyrun
  ];
}

