{ lib, config, username, impermanence, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.meadow.impermanence;
in {
  options.meadow.impermanence.enable = mkEnableOption "impermanence";

  config = mkIf cfg.enable {
    users.users."${username}" = {
      hashedPasswordFile = "/persist/passwords/user"; # Path to user's hashed password
      uid = 1000; # User ID
    };

    environment.persistence."/persist" = {
      directories = [
        "/etc/nixos"
        "/etc/secureboot"
        "/var/db/sudo"
        "/var/lib/tailscale"
      ];

      files = [
        "/etc/machine-id"
        "/etc/wg.key"
      ];
    };
  };
}
