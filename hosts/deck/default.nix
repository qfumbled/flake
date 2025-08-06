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
    tpm2.enable = true;
    lanzaboote = {
      enable = true;
    };
  };
}
