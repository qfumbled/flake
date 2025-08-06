{...}: {
  imports = [
    ../common
    ./hardware-configuration.nix
    ./networking.nix
  ];

  opt = {
    zram.enable = true;
    flatpak.enable = true;
    zram.size = "5G";
    tpm2.enable = true;
    vram.enable = true;
    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
