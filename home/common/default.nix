{
  pkgs,
  inputs,
  system,
  lib, # add lib here to use lib.mkForce
  ...
}: let
  app2unit = pkgs.callPackage ../../packages/app2unit {};
in {
  imports = [
    ./shell.nix
    ./git.nix
    ./rnoise.nix
    ./xdg.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "monaco";
    homeDirectory = "/home/monaco";

    programs.spicetify.theme.name = lib.mkForce "Comfy";

    packages = with pkgs; [
      fastfetch
      onefetch
      git
      dconf
      fzf
      ripgrep
      vlc
      gh
      rar
      app2unit
      vial
      inputs.zen-browser.packages."${system}".default
    ];

    sessionVariables = {
      FLAKE = "/home/monaco/flake";
    };

    stateVersion = "25.05";
  };
}
