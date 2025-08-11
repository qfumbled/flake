{pkgs, ...}: {
  imports = [
    ../common
    ./stylix
    ./plasma.nix
    ./spotify.nix
  ];

  home.packages = with pkgs; [
  ];
}
