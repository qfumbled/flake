{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.opt.flatpak;
in {
  options.opt.flatpak = {
    enable = lib.mkEnableOption "Enable flatpak service with flathub and org.vinegarhq.Sober";
  };

  config = lib.mkIf cfg.enable {
    services.flatpak = {
      enable = true;
      update.onActivation = true;
      remotes = [
        {
          name = "flathub";
          location = "https://flathub.org/repo/flathub.flatpakrepo";
        }
      ];
      packages = [
        {
          appId = "org.vinegarhq.Sober";
          origin = "flathub";
        }
      ];
    };
  };
}
