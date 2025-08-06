{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.opt.zram;
in {
  options.opt.zram = {
    enable = mkEnableOption "Enable zram-based swap";
    size = mkOption {
      type = types.str;
      default = "5G";
      description = "Size of the zram swap device (e.g. 5G, 4096M)";
    };
  };

  config = mkIf cfg.enable {
    zramSwap.enable = true;

    systemd.services."zram-swap".serviceConfig = {
      Environment = "ZRAM_SIZE=${cfg.size}";
    };

    swapDevices = [
      {
        device = "/var/lib/swapfile";
        size = 15 * 1024; # size in MiB
      }
    ];
  };
}
