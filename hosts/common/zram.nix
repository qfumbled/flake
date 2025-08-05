{
  config,
  pkgs,
  ...
}: {
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 16 * 1024; # Size in MiB (16 GiB)
    }
  ];

  zramSwap.enable = true;
}
