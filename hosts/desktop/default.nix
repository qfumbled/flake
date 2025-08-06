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
    flatpak.enable = true;
    tpm2.enable = true;
    pipewire.enable = true;

    lanzaboote = {
      enable = true;
      # optionally override the default pkiBundle path:
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
