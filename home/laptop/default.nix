{pkgs, ...}: {
  imports = [
    ../common
    ./stylix
    ./plasma.nix
  ];

  home.packages = with pkgs; [
  ];
}
