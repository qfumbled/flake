{
  qt = {
    enable = true;
    platformTheme = "qt6ct";
    style = "kvantum";
  };

  environment.systemPackages = with pkgs; [
    qt5ct
    kvantum
  ];

  environment.variables = {
    QT_QPA_PLATFORMTHEME = "qt5ct";
    QT_STYLE_OVERRIDE = "kvantum";
  };
}
