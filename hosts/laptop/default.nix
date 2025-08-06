{...}: {
  imports = [
    ../common
    ./hardware-configuration.nix
    ./networking.nix
  ];

  opt = {
    zram.enable = true;
    tpm2.enable = true;
    vram.enable = true;
    lanzaboote = {
      enable = true;
      # optionally:
      # pkiBundle = "/var/lib/sbctl";
    };
  };
}
