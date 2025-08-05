{pkgs, ...}: {
  imports = [
    ../common
    ./plasma.nix
  ];

  home.packages = with pkgs; [
  ];
}
