{...}: {
  imports = [
    ../common
    /etc/nixos/hardware-configuration.nix
    ./networking.nix
    ../../system/core/default.nix
    ./gaming.nix
    ./plasma.nix
    ../../system/core/deck-default.nix
  ];
}
