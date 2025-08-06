{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.opt.vram;
in {
  options.opt.vram = {
    enable = mkEnableOption "Enable setting VRAM size for Intel GPU";
    sizeMB = mkOption {
      type = types.int;
      default = 7680; # 7.5 GB in MB
      description = "VRAM size in MB for Intel GPU (sets i915.vram_limit_mb kernel parameter)";
    };
  };

  config = mkIf cfg.enable {
    boot.kernelParams = mkForce [
      "i915.vram_limit_mb=${toString cfg.sizeMB}"
    ];
  };
}
