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
    pipewire.enable = true;
    lanzaboote = {
      enable = true;
    };
  };
}
