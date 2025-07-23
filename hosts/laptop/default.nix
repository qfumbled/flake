{...}: {
  imports = [
    ../common
    /etc/nixos/hardware-configuration.nix # i do this all the time so your system can be bootable
    ./networking.nix
    ./zram.nix # if you don't want zram tag this by doing # on the ./zram.nix
    ./module.nix # code combined mess
    ../../system/core/default.nix
    ../../system/hardware/default.nix
  ];
}
