{pkgs, ...}: {
  imports = [
    ./shell.nix
    ./zed.nix
    ./git.nix
    #./firefox.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "xoc";
    homeDirectory = "/home/xoc";

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
    ];

    sessionVariables = {
      FLAKE = "/home/wien/nixos";
    };

    stateVersion = "25.05";
  };
}
