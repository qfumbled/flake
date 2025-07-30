{pkgs, ...}: {
  imports = [
#  ./niri.nix doing some things to make this work
   ./anyrun.nix
   ./nu.nix
   ./git.nix
   ./zed.nix
  ];
  programs.home-manager.enable = true;
}
