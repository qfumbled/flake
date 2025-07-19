{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./shell.nix
    ./zed.nix
    ./git.nix
    #./firefox.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "wien";
    homeDirectory = "/home/wien";

    packages = with pkgs; [
      fastfetch
      git
      firefox
      fzf
      ripgrep
      vlc
      gh
      nh
      converseen
      spotify
      kdePackages.kalk
      kdePackages.klevernotes
    ];

    sessionVariables = {
      FLAKE = "/home/wien/nixos";
    };

    stateVersion = "25.05";
  };
}
