{...}: {
  imports = [
    ../common
    ./hardware-configuration.nix
    ./networking.nix
  ];

  opt = {
    zram.enable = true;
    flatpak.enable = true;
    zram.size = "15G";
    tpm2.enable = true;
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
