{pkgs, ...}: {
  imports = [
    ../common
    ./plasma.2.nix
  ];
  # normal plasma is plasma.nix plasma.2.nix if you wanna be the same as desktop
  home.packages = with pkgs; [
  ];
}
