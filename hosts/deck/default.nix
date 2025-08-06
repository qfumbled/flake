{...}: {
  imports = [
    ../common
    ./hardware-configuration.nix
    ./networking.nix
    ./gaming.nix
    ./plasma.nix
  ];

  opt = {
    zram.enable = false;
    flatpak.enable = true;
    tpm2.enable = true;
    vram.enable = false;
    lanzaboote = {
      enable = true;
    };
  };
}
