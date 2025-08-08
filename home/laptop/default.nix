{pkgs, ...}: {
  imports = [
    ../common
    ./spotify.nix
    ./plasma.nix
    ./zed.nix
  ];

  home.packages = with pkgs; [
  ];
}
