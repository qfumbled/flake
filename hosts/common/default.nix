{...}: {
  imports = [
    ./audio.nix
    ./boot.nix
    ./locales.nix
    ./misc.nix
    ./networking.nix
    ./nixpkgs.nix
    ./plasma.nix
    ./optimize.nix
    ./logitech.nix
    ./bluetooth.nix
    ./nix.nix
  ];
  programs.nix-ld.enable = true; # good old patch
}
