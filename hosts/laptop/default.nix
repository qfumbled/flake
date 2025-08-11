{
  imports = [
    ../common
    ./stylix
    ./hardware-configuration.nix
    ./networking.nix
    ./users.nix
  ];

  opt = {
    flatpak.enable = true;

    zram = {
      enable = true;
      size = "15G";
    };

    tpm2 = {
      enable = true;
    };
  };
}
