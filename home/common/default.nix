
{pkgs, ...}: {
  imports = [
    ./shell.nix
    ./zed.nix
#    ./firefox.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "dulish";
    homeDirectory = "/home/dulish";

    packages = with pkgs; [
      fastfetch
      git
      firefox
      fzf
      ripgrep
      vlc
      gh
      nh
     obs-studio-plugins.input-overlay
     obs-studio
      converseen
      kdePackages.kalk
      kdePackages.kget
      kdePackages.neochat
      kdePackages.klevernotes
    ];

    sessionVariables = {
      FLAKE = "/home/poacher/nix-dotfiles";
    };

    stateVersion = "25.05";
  };
}
