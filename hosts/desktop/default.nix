{...}: {
  imports = [
    ../../modules/nixos
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
    pipewire = true;

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
