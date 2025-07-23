{...}: {
  imports = [
    ./docs.nix
    ./flatpak.nix
    ./nix.nix
    ./users.nix
    ./security.nix
    ../hardware/default.nix
  ];
