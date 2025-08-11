{pkgs, ...}: {
  imports = [
    ./shell.nix
    ./zed.nix
    ./zen.nix
    ./git.nix
    ./gpg.nix
    ./gpg-agent.nix
    ./obs.nix
    ./polkit-agent.nix
    ./rnnoise.nix
    ./bat.nix
    ./zoxide.nix
  ];

  programs.home-manager.enable = true;

  home = {
    username = "monaco";
    homeDirectory = "/home/monaco";

    packages = with pkgs; [
      fastfetch
      onefetch
      git
      fzf
      ripgrep
      vlc
      gh
      nh
      converseen
      rar
    ];

    sessionVariables = {
      FLAKE = "/home/poacher/nix-dotfiles";
      NIXPKGS_ALLOW_UNFREE = 1;
    };

    stateVersion = "25.05";
  };
}
