{ 
  lib,
  config,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption;
in
{
  options.meadow.services = { };

  config = {
    services = {
      gvfs.enable = true;
      blueman.enable = true;
      dbus.enable = true;

      tailscale = mkIf config.meadow.programs.tailscale.enable { enable = true; };

      xserver.xkb = {
        layout = "us";
        options = "compose:rctrl,caps:escape";
      };

      gnome = {
        gnome-keyring.enable = true;
        glib-networking.enable = true;
      };

      printing.enable = true;

      dbus.implementation = "broker";

      # profile-sync-daemon
      psd = {
        enable = true;
        resyncTimer = "10m";
      };

      irqbalance.enable = true;
    };

    powerManagement = {
      enable = true;
      powerDownCommands = ''
        # Lock all sessions
        loginctl lock-sessions

        # Wait for lockscreen(s) to be up
        sleep 1
      '';
    };
  };

  imports = lib.meadow.readSubfiles ./. [ "default.nix" ];
}
