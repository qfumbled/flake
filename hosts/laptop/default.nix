{themeName, ...}: {
  imports = [
    ../../modules/nixos
    ./hyprland.nix
    ./stylix
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

    tpm2 = {
      enable = true;
    };

    lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
    };
  };
}
