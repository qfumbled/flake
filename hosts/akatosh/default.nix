{ config, pkgs, ... }:

{
  imports = [
    ./hardware.nix
    ../../modules/nixos
  ];

  networking.hostName = "akatosh";

  meadow = {
    programs = {
      tailscale.enable = false;
      wayland.enable = true;
      steam.enable = false;
    };
    services = {
      pipewire.enable = true;
      wireguard.enable = false;
    };
    impermanence.enable = true;
  };
  security.rtkit.enable = true;
  services.printing.enable = true;
}
