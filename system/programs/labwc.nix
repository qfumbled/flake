{
  config,
  pkgs,
  ...
}:

{
  programs = {
    labwc.enable = true;

    uwsm = {
      enable = true;
      waylandCompositors = {
        labwc = {
          prettyName = "labwc";
          comment = "Labwc compositor managed by UWSM";
          binPath = "/etc/profiles/per-user/wug/bin/labwc";
        };
      };
    };
  };

  systemd.user.services.uwsm = {
    description = "Start UWSM login manager";
    serviceConfig.ExecStart = "/run/current-system/sw/bin/uwsm start labwc";
    serviceConfig.Restart = "always";
    wantedBy = [ "default.target" ];
    enable = true;
  };
}
