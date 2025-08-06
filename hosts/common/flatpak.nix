{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.opt.flatpak;
in {
  options.opt.flatpak = {
    enable = lib.mkEnableOption "Enable flatpak service with flathub-beta and org.vinegarhq.Sober";
  };

  config = lib.mkIf cfg.enable {
    services.flatpak = {
      enable = true;
      update.onActivation = true;
      remotes = [
        {
          name = "flathub-beta";
          location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
        }
      ];
      packages = [
        {
          appId = "org.vinegarhq.Sober";
          origin = "flathub-beta";
        }
      ];
    };
  };
}
