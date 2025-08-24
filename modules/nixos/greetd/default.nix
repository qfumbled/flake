{ pkgs, username, ... }:
{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd labwc";
        user = username;
      };
    };
  };
}
