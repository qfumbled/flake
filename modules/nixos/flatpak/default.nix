{ 
  inputs,
  config,
  pkgs,
  ...
}:

{
  services.flatpak = {
    enable = true;
    update.onActivation = true;
    packages = [
      {
        appId = "org.vinegarhq.Sober";
        origin = "flathub";
      }
    ];
  };
}
