{
  lib,
  config,
  username,
  ...
}:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.meadow.impermanence;
in
{
  options.meadow.impermanence.enable = mkEnableOption "impermanence";
  config = mkIf cfg.enable {
    users = {
      users."${username}" = {
        hashedPasswordFile = "/persist/passwords/user";
        uid = 1000;
      };
    };
    environment.persistence."/persist" = {
      directories = [
        "/etc/nixos"
        "/var/lib/machines"
        "/etc/secureboot"
        "/var/db/sudo"
        "/var/lib/tailscale"
      ];
      files = [
        "/etc/machine-id"
        "/etc/wg.key"
        "/tmp"
      ];
    };
  };
}
