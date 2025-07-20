{...}: {
  imports = [
    ../common
    /etc/nixos/hardware-configuration.nix
    ./networking.nix
    ./users.nix
  ];
 services.fwupd.enable = true; # works on some lenovo models and a lot of framework   
}
