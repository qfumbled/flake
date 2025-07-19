{ pkgs, ... }: {
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.kdePackages.xdg-desktop-portal-kde ]; 
  };

  services = {
    flatpak = {
      enable = true;
    };
  };
}
