{...}: {
  programs.vesktop = {
    enable = true;
    settings = {
      minimizeToTray = false;
      tray = false;
      hardwareAcceleration = true;
      customTitleBar = true;
    };
  };
}
