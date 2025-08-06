{...}: {
  imports = [
    ../common
    ./hardware-configuration.nix
    ./networking.nix
  ];

  opt = {
    pipewire.enable = true;
    flatpak.enable = true;

    zram = {
      enable = true;
      size = "15G";
    };

    tpm2 = {
      enable = true;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
