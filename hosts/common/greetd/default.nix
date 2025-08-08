{ pkgs, ... }:

{
  services.lightdm.enable = false;
  services.gdm.enable = false;

  # Enable greetd with tuigreet
  services.greetd = {
    enable = true;
    vt = 3;
    settings = {
      default_session = {
        user = "monaco";  # your username
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd startplasma-wayland";
      };
    };
  };
}
