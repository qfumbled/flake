{pkgs, ...}: {
  imports = [
    ../common
    ./spotify.nix
    ./plasma.nix
  ];

  home.packages = with pkgs; [
  ];
}
