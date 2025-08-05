{...}: {
  config = {
    users.users.monaco = {
      isNormalUser = true;
      uid = 1000;
      hashedPasswordFile = "/persist/passwords/user";
    };

    environment.persistence."/persist" = {
      directories = [
        "/etc/nixos"
        "/etc/secureboot"
        "/var/db/sudo"
        "/var/lib/tailscale"
        "/var/lib/systemd/coredump"
        "/var/log"
        "/var/lib/nixos"
        "/persist/passwords"
      ];
      files = [
        "/etc/machine-id"
        "/etc/wg.key"
        "/persist/passwords/user"
      ];
    };

    system.activationScripts.createPasswordFile = {
      text = ''
        echo "[+] Ensuring password file exists at /persist/passwords/user"
        install -d -m 700 -o root -g root /persist/passwords
        if [ ! -f /persist/passwords/user ]; then
          echo '[+] Creating password file'
          echo '$6$/d.pgzfuTq2metTH$4t.IIo6H46OAbhpnmon18yIedo6Iz41NgrGiup4tBG8DCW3VOQCRzt.Fldz1077mIRa/QWv2yQw1unWCx5Lxt/' > /persist/passwords/user
          chmod 600 /persist/passwords/user
          chown root:root /persist/passwords/user
        fi
      '';
    };
  };
}
