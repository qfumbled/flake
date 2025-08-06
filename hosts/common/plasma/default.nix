{ pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;

  services.desktopManager.plasma6.enable = true;

  environment.plasma6.excludePackages = [
    pkgs.kdePackages.plasma-browser-integration
    pkgs.kdePackages.kate
    pkgs.kdePackages.okular
    pkgs.kdePackages.kwalletmanager
  ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };
}
