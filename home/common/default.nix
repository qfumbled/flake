{
  pkgs,
  inputs,
  system,
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
