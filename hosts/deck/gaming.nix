{jovian, ...}: {
  imports = [
    jovian.nixosModules.default
  ];

  programs.steam.enable = true;
  programs.steam.gamescopeSession.enable = true;
  programs.gamemode.enable = true;

  jovian = {
    steam = {
      enable = true;
      autoStart = true;
      updater.splash = "jovian";
      user = "monaco";
      desktopSession = "plasma";
    };

    devices.steamdeck = {
      enable = true;
      autoUpdate = true;
      enableGyroDsuService = true;
    };

    decky-loader = {
      enable = true;
      user = "monaco";
    };
  };

  services.lsfg-vk.enable = true;
}
