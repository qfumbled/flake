{
  pkgs,
  inputs,
  lib,
  ...
}: let
  quickshell = inputs.quickshell.packages.${pkgs.system}.default;
in {
  home.packages = [
    quickshell
    pkgs.matugen
    pkgs.kdePackages.qt5compat
    pkgs.kdePackages.qtbase
    pkgs.kdePackages.qtdeclarative
    pkgs.gpu-screen-recorder
  ];

  home.sessionVariables = {
    QML2_IMPORT_PATH = lib.concatStringsSep ":" [
      (lib.makeSearchPath "lib/qt-6/qml" [
        quickshell
        pkgs.kdePackages.qtdeclarative
        pkgs.kdePackages.kirigami.unwrapped
        pkgs.kdePackages.qt5compat
      ])
    ];
  };
}
