{ config, pkgs, ... }:

{
  imports = [
     inputs.hm.nixosModules.home-manager
     inputs.impermanence.nixosModules.impermanence
     inputs.nix-flatpak.nixosModules.nix-flatpak
     inputs.stylix.nixosModules.stylix
    ./hardware.nix
  ];

  networking.hostName = "magnus";

  meadow = {
    programs = {
      tailscale.enable = true;
      wayland.enable = true;
      steam.enable = false;
    };
    services = {
      pipewire.enable = true;
      kanata.enable = true;
      wireguard.enable = false;
    };
    impermanence.enable = true;
  };
  security.rtkit.enable = true;
  services.printing.enable = true;
}
