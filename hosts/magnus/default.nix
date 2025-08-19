{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/nixos
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
      wireguard.enable = false;
    };
    impermanence.enable = true;
  };
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  security.rtkit.enable = true;
  services.printing.enable = true;
}
