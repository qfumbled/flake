{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.opt.zram;
in {
  options.opt.zram = {
    enable = lib.mkEnableOption "Enable zram-based swap";
  };

  config = lib.mkIf cfg.enable {
    zramSwap.enable = true;
  };
}
