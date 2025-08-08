{themeName, ...}: {
  imports = [
    ../common
    ./hardware-configuration.nix
    ./networking.nix
  ];

  opt = {
    pipewire = true;
    flatpak.enable = true;

    zram = {
      enable = true;
      size = "15G";
    };
    stylix = {
      enable = true;
      polarity = "dark";
      themeName = far;
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
