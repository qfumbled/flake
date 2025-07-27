{
  services.flatpak.packages = [
    { appId = "org.vinegarhq.Sober"; origin = "flathub"; }
  ];

  services.flatpak.update.onActivation = true;
  services.flatpak.enable = true;
}
