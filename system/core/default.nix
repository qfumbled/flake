{...}: {
  imports = [
    ./lanzaboote.nix # secure boot for nixos
    ./security.nix
    ./users.nix
    ./flatpak.nix
    ./docs.nix
    ./nix.nix
    ./audio.nix
  ];
}
