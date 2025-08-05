{pkgs, ...}: let
  app2unit = pkgs.callPackage ../../packages/app2unit {};
in {
  imports = [
    ./shell.nix
    ./zed.nix
    ./firefox.nix
    ./git.nix
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
    ];

    sessionVariables = {
      FLAKE = "/home/monaco/flake";
    };

    stateVersion = "25.05";
  };
}
