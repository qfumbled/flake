{
  pkgs,
  lib,
  inputs,
  ...
}:
# lanzaboote config
{
  boot = {
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };

    # we let lanzaboote install systemd-boot
    loader.systemd-boot.enable = lib.mkForce false;
  };

  environment.systemPackages = [pkgs.sbctl];
}
