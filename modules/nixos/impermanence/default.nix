{ lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.meadow.impermanence;
in
{
  options.meadow.impermanence.enable = mkEnableOption "impermanence";

  # Enable impermanence if the option is enabled
  config = mkIf cfg.enable {
    users = {
      # User configuration for 'wug'
      users.wug = {
        hashedPasswordFile = "/persist/passwords/user";  # Path to user's hashed password
        uid = 1000;  # User ID
      };
    };

    # Define persistence for the specified directories and files
    environment.persistence."/persist" = {
      directories = [
        "/etc/nixos"
        "/etc/NetworkManager/system-connections"
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
