{ pkgs, ... }:
{
  programs.home-manager.enable = true;

 imports = [
   ../../modules/home/profiles/grovetender
  ];

  home.username = "wieners";
  home.homeDirectory = "/home/wieners";

  home.packages = with pkgs; [
    fastfetch
    git
    firefox
    fzf
    ripgrep
    vlc
    gh
    nh
    converseen
  ];

  home.stateVersion = "25.05";
}

