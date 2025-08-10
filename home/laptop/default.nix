{pkgs, ...}: {
  imports = [
    ../common
    ./spotify.nix
    ./plasma.nix
    ./zed.nix
    ./hyprland
    ./ags.nix
    ./foot.nix
  ];

  home.packages = with pkgs; [
  ];
}
