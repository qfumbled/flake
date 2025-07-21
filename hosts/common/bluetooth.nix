# /etc/nixos/configuration.nix
{
  config,
  pkgs,
  ...
}: {
  hardware.bluetooth.enable = true; # Enables support for Bluetooth
  hardware.bluetooth.powerOnBoot = true; # Powers up the Bluetooth controller on boot

  # services.blueman.enable = true;
}
