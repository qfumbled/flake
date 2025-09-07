{ 
  config, 
  pkgs, 
  inputs, 
  lib, 
  ... 
}:

{
  imports = [
  inputs.impermanence.nixosModules.impermanence
  inputs.nix-flatpak.nixosModules.nix-flatpak
  inputs.agenix.nixosModules.default
  inputs.chaotic.nixosModules.default
    ./hardware.nix
  ];

  networking.hostName = "grovetender"; # Define your hostname

  meadow = {
    programs = {
      tailscale.enable = true;
      wayland.enable = true;
      steam.enable = false;
    };

    services = {
      kanata.enable = true;
      tpm.enable = true;
      pipewire.enable = true;
      wireguard.enable = false;
    };

    impermanence.enable = true;
  };
}
