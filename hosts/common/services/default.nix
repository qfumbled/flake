{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
in {
  options.opt = {
    pipewire = mkEnableOption "Enable PipeWire audio backend";
  };

  config = {
    services = {
      dbus.enable = true;
      gvfs.enable = true;
      blueman.enable = true;
      upower.enable = true;

      logind = {
        powerKey = "suspend";
        lidSwitch = "suspend";
        lidSwitchExternalPower = "lock";
      };

      pipewire = mkIf config.opt.pipewire {
        enable = true;
        alsa.enable = true;
        pulse.enable = true;
        jack.enable = false;
      };

      xserver.xkb = {
        layout = "us";
        options = "compose:rctrl,caps:escape";
      };
    };
  };
}
