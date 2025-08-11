{pkgs, ...}: {
  imports = [
    ../common
    ./spotify.nix
    ./plasma.nix
    ./zed.nix
    ./niri/default.nix
  ];

  home.packages = with pkgs; [
  ];
}
