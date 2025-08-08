{themeName, ...}: {
  imports = [
    ../common
    ./hardware-configuration.nix
    ./networking.nix
  ];

  stylix.enable = true;
  stylix.polarity = "dark";
  stylix.themeName = "far";

  opt = {
    pipewire = true;
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

  # No stylix here anymore
}
