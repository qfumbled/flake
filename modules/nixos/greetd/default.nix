{pkgs, ...}: {
  services.greetd = {
    enable = true;
    vt = 3;
    settings = {
      default_session = {
        user = "monaco";
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --cmd startplasma-wayland";
      };
    };
  };
}
