{ config, pkgs, ... } @ args:

let
  inputs = args.inputs;
in

{
  imports = [
    inputs.hm.nixosModules.home-manager
    inputs.impermanence.nixosModules.impermanence
    inputs.nix-flatpak.nixosModules.nix-flatpak
    inputs.stylix.nixosModules.stylix
    ./hardware.nix
  ];

  networking.hostName = "akatosh";

  meadow = {
    programs = {
      tailscale.enable = false;
      wayland.enable = true;
      steam.enable = false;
    };
    services = {
      kanata.enable = false;
      tpm.enable = true;
      pipewire.enable = true;
      wireguard.enable = false;
    };
    impermanence.enable = true;
  };

  security.rtkit.enable = true;
  services.printing.enable = true;
}
