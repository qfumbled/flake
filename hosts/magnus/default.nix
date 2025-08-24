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
      tpm.enable = true;
      kanata.enable = true;
      wireguard.enable = false;
    };
    impermanence.enable = true;
  };
  security.rtkit.enable = true;
  services.printing.enable = true;
}
