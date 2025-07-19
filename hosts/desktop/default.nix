{...}: {
  imports = [
    ../common
    /etc/nixos/hardware-configuration.nix
    ./nvidia.nix
    ./gaming.nix
    ./networking.nix
    ./users.nix
    ./misc.nix
  ];
}
