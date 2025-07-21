{...}: {
  imports = [
    ../common
    /etc/nixos/hardware-configuration.nix
    ./networking.nix
    ./users.nix
    ./zram.nix # if you don't want zram tag this by doing # on the ./zram.nix
  ];
}
