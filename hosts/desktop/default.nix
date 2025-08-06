{...}: {
  imports = [
    ../common
    ./hardware-configuration.nix
    ./nvidia.nix
    ./gaming.nix
    ./networking.nix
    ./misc.nix
  ];

  opt = {
    zram.enable = false;
    zram.size = "0G";
    vram.enable = false;
    tpm2.enable = true;

    lanzaboote = {
      enable = true;
      # optionally override the default pkiBundle path:
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
