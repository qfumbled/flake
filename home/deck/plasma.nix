{...}: {
  programs.plasma = {
    enable = true;

    panels = [
      {
        opacity = "opaque";
        location = "top";
        height = 30;
        floating = false;
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.panelspacer"
          {
            digitalClock = {
              date.enable = false;
            };
          }
          "org.kde.plasma.panelspacer"
          "org.kde.plasma.systemtray"
        ];
      }

      {
        opacity = "opaque";
        location = "bottom";
        height = 48;
        floating = true;
        hiding = "autohide";
        lengthMode = "fit";
        widgets = [
          {
            name = "org.kde.plasma.icontasks";
            config = {
              General.launchers = [
                "applications:steam.desktop"
                "applications:firefox.desktop"
                "applications:dev.zed.Zed.desktop"
                "applications:org.kde.konsole.desktop"
                "applications:org.kde.dolphin.desktop"
              ];
            };
          }
        ];
      }
    ];
  };
}
