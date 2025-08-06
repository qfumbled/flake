{
  config,
  lib,
  pkgs,
  ...
}:
with lib; let
  cfg = config.opt.zram;
in {
  options.opt.zram = {
    enable = lib.mkEnableOption "Enable zram-based swap";
    size = mkOption {
      type = with lib.types; nonEmptyStr;
      default = "5G";
      description = "Size of the zram swap device";
    };
  };

  config = lib.mkIf cfg.enable {
    zramSwap.enable = true;
    # Set the size explicitly using a systemd service override
    systemd.services."zram-swap".serviceConfig = {
      Environment = "ZRAM_SIZE=${cfg.size}";
    };
  };
}
