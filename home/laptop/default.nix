{pkgs, ...}: {
  imports = [
    ../common
    ./spotify.nix
    ./plasma.nix
    ./zed.nix
    ./foot.nix
  ];

  home.packages = with pkgs; [
  ];
}
