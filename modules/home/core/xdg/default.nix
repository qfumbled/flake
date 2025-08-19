{pkgs, ...}: {
  home.packages = with pkgs; [
    xdg-utils
  ];

  xdg = {
    enable = true;
    userDirs = {
      enable = true;
      createDirectories = true;
    };

    portal = {
      enable = true;
      extraPortals = with pkgs; [xdg-desktop-portal-wlr];
      config = {
        labwc = {
          default = ["wlr" "*"];
          "org.freedesktop.impl.portal.Inhibit" = ["none"];
        };
      };
    };

    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = ["zen-beta.desktop"];
        "x-scheme-handler/https" = ["zen-beta.desktop"];
        "x-scheme-handler/chrome" = ["zen-beta.desktop"];
        "text/html" = ["firefox.desktop"];
        "application/x-extension-htm" = ["zen-beta.desktop"];
        "application/x-extension-html" = ["zen-beta.desktop"];
        "application/x-extension-shtml" = ["zen-beta.desktop"];
        "application/xhtml+xml" = ["zen-beta.desktop"];
        "application/x-extension-xhtml" = ["zen-beta.desktop"];
        "application/x-extension-xht" = ["zen-beta.desktop"];
      };
    };
  };
}
