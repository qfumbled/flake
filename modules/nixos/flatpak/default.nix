{ config, pkgs, ... }:

{
 services.flatpak.update.onActivation = true;
  services.flatpak.enable = true;
  services.flatpak.packages = [
    { appId = "org.vinegarhq.Sober"; origin = "flathub"; }
  ];
}
