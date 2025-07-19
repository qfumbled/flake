{pkgs, ...}: {
  imports = [
    ../common
    ./plasma.nix
  ];
  # normal plasma is plasma.nix plasma.2.nix if you wanna it to be the same as your desktop
  home.packages = with pkgs; [
  ];
}
