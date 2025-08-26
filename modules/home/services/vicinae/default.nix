{ config, lib, pkgs, ... }:

with lib;

let
  vicinae = pkgs.stdenv.mkDerivation rec {
    pname = "vicinae";
    version = "0.2.1";

    src = pkgs.fetchurl {
      url = "https://github.com/vicinaehq/vicinae/releases/download/v${version}/vicinae-linux-x86_64-v${version}.tar.gz";
      sha256 = "sha256-c2YC/i2yul3IKasUexKrW0o87HE8X60aBzkS+I7nnQI=";
    };

    nativeBuildInputs = with pkgs; [
      autoPatchelfHook
      qt6.wrapQtAppsHook
    ];

    buildInputs = with pkgs; [
      qt6.qtbase
      qt6.qtsvg
      qt6.qttools
      qt6.qtwayland
      qt6.qtdeclarative
      qt6.qt5compat
      kdePackages.qtkeychain
      kdePackages.layer-shell-qt
      openssl
      cmark-gfm
      libqalculate
      minizip
      stdenv.cc.cc.lib
      abseil-cpp
      protobuf
      nodejs
      wayland
    ];

    unpackPhase = ''
      tar -xzf $src
    '';

    installPhase = ''
      mkdir -p $out/bin $out/share/applications
      cp bin/vicinae $out/bin/
      cp share/applications/vicinae.desktop $out/share/applications/
      chmod +x $out/bin/vicinae
    '';

    dontWrapQtApps = true;

    preFixup = ''
      wrapQtApp "$out/bin/vicinae" --prefix LD_LIBRARY_PATH : ${lib.makeLibraryPath buildInputs}
    '';

    meta = {
      description = "A focused launcher for your desktop — native, fast, extensible";
      homepage = "https://github.com/vicinaehq/vicinae";
      license = pkgs.lib.licenses.gpl3;
      maintainers = [ ];
      platforms = pkgs.lib.platforms.linux;
    };
  };
in
{
  options.enableVicinae = mkEnableOption "Enable Vicinae launcher daemon";

  config = mkIf config.enableVicinae {
    home.packages = [ vicinae ];

    home.file.".config/vicinae/themes/custom.json" = {
      text = builtins.toJSON {
        version = "1.0.0";
        appearance = "dark";
        icon = "";
        name = "Custom Theme";
        description = "Theme generated from NixOS defaults colorScheme";
      };
    };

    systemd.user.services.vicinae = {
      Unit = {
        Description = "Vicinae launcher daemon";
        After = [ "graphical-session-pre.target" ];
        PartOf = [ "graphical-session.target" ];
      };

      Service = {
        Type = "simple";
        ExecStart = "${vicinae}/bin/vicinae server";
        Restart = "on-failure";
        RestartSec = 3;
      };

      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}
