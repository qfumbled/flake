{...}: {
  programs.vesktop = {
    enable = false;
    settings = {
      minimizeToTray = false;
      tray = false;
      hardwareAcceleration = true;
      customTitleBar = true;
    };
  };
}
