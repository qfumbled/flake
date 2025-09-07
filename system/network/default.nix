{
  pkgs,
  lib,
  ...
}: {
  imports = lib.meadow.readSubfiles ./. [ "default.nix" ];

  networking = {
    nftables.enable = true;

    networkmanager = {
      enable = true;
      dns = "systemd-resolved";
    };

    firewall.allowedTCPPorts = [4444];
  };

  services = {
    openssh = {
      enable = true;
      settings.UseDns = true;
    };

    resolved = {
      enable = true;
      dnsovertls = "opportunistic";
    };
  };

  systemd.services.NetworkManager-wait-online.serviceConfig.ExecStart = ["" "${pkgs.networkmanager}/bin/nm-online -q"];

  environment.etc.hosts.enable = false;
}
