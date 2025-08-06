{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.opt.vram;
in {
  options.opt.vram = {
    enable = lib.mkEnableOption "Enable setting VRAM size for Intel GPU";
    sizeMB = lib.mkOption {
      type = lib.types.int;
      default = 8192;
      description = "VRAM size in MB for Intel GPU (sets i915.vram_limit_mb kernel parameter)";
    };
  };

  config = lib.mkIf cfg.enable {
    boot.kernelParams = lib.mkForce [
      "i915.vram_limit_mb=${toString cfg.sizeMB}"
    ];
  };
}
