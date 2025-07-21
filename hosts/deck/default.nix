{...}: {
  imports = [
    ../common
    /etc/nixos/hardware-configuration.nix
    ./networking.nix
    ./users.nix
    ./gaming.nix
    ./plasma.nix
  ];
}
