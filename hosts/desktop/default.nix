{...}: {
  imports = [
    ../common
    ./hardware-configuration.nix
    ./nvidia.nix
    ./gaming.nix
    ./networking.nix
    ./misc.nix
  ];
}
