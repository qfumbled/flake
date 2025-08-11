{
  imports = [
    ../common
    ./hardware-configuration.nix
    ./networking.nix
    ./users.nix
    ./gaming.nix
    ./plasma.nix
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
