{ lib, config, ... }:
let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.meadow.services.wireguard;
in
{
  options.meadow.services.wireguard.enable = mkEnableOption "wireguard";

  # Enable WireGuard
  config.networking.wireguard.interfaces = mkIf cfg.enable {
    wg0 = {
      # IP address and subnet for the client's end of the tunnel
      ips = [ "172.20.0.4/24" ];

      # Path to the private key file
      privateKeyFile = "/etc/wg.key";

      peers = [
        {
          # Public key of the server
          publicKey = "yXXuXdf9g0+OvRWGfjR6eCKh8616qABhhzMxHb8ydFU=";

          # Forward all traffic via VPN
          allowedIPs = [ "0.0.0.0/0" ];

          # Server IP and port
          endpoint = "vpn.elyth.xyz:51820";

          # Send keepalives every 25 seconds
          persistentKeepalive = 25;
        }
      ];
    };
  };
}
