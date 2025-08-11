{
  imports = [
    ../common
    ./hardware-configuration.nix
    ./nvidia.nix
    ./gaming.nix
    ./networking.nix
    ./users.nix
    ./misc.nix
  ];

  opt = {
    pipewire = true;
    flatpak.enable = true;

    zram = {
      enable = false;
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
