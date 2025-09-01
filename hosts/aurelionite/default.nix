{ 
  config, 
  pkgs, 
  inputs, 
  lib, 
  ... 
}:

{
  imports = [
    inputs.hm.nixosModules.home-manager
    inputs.impermanence.nixosModules.impermanence
    inputs.stylix.nixosModules.stylix

    ./hardware.nix
  ];

  networking.hostName = "aurelionite"; # Define your hostname

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
