{ lib, config, ... }:
{
  config = {
    users.users.monaco = {
      hashedPasswordFile = "$6$/d.pgzfuTq2metTH$4t.IIo6H46OAbhpnmon18yIedo6Iz41NgrGiup4tBG8DCW3VOQCRzt.Fldz1077mIRa/QWv2yQw1unWCx5Lxt/";
      uid = 1000;
    };

    environment.persistence."/persist" = {
      directories = [
        "/etc/nixos"
        "/etc/secureboot"
        "/var/db/sudo"
        "/var/lib/tailscale"
        "/var/lib/systemd/coredump"
        "/var/log"
      ];
      files = [
        "/etc/machine-id"
        "/etc/wg.key"
      ];
    };
  };
}
