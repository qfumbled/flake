{pkgs, ...}: {
  imports = [
    ../common
    ./plasma.nix
    ./spotify.nix
  ];

  home.packages = with pkgs; [
  ];
}
