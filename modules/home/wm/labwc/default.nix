{
  config,
  lib,
  pkgs,
  ...
}:

let
  cfg = config.meadow.default.wm == "labwc";
  inherit (lib) mkIf;
  _ = lib.getExe;

  ocrScript =
    let
      inherit (pkgs) grim libnotify slurp tesseract5 wl-clipboard;
    in
    pkgs.writeShellScriptBin "wl-ocr" ''
      ${_ grim} -g "$(${_ slurp})" -t ppm - | ${_ tesseract5} - - | ${wl-clipboard}/bin/wl-copy
      ${_ libnotify} "$(${wl-clipboard}/bin/wl-paste)"
    '';

  volumectl =
    let
      inherit (pkgs) libnotify pamixer libcanberra-gtk3;
    in
    pkgs.writeShellScriptBin "volumectl" ''
      case "$1" in
      up)
        ${_ pamixer} -i "$2"
        ;;
      down)
        ${_ pamixer} -d "$2"
        ;;
      toggle-mute)
        ${_ pamixer} -t
        ;;
      esac

      volume_percentage="$(${_ pamixer} --get-volume)"
      isMuted="$(${_ pamixer} --get-mute)"

      if [ "$isMuted" = "true" ]; then
        ${libnotify}/bin/notify-send --transient \
          -u normal \
          -a "VOLUMECTL" \
          -i audio-volume-muted-symbolic \
          "VOLUMECTL" "Volume Muted"
      else
        ${libnotify}/bin/notify-send --transient \
          -u normal \
          -a "VOLUMECTL" \
          -h string:x-canonical-private-synchronous:volumectl \
          -h int:value:"$volume_percentage" \
          -i audio-volume-high-symbolic \
          "VOLUMECTL" "Volume: $volume_percentage%"

        ${libcanberra-gtk3}/bin/canberra-gtk-play -i audio-volume-change -d "volumectl"
      fi
    '';

  lightctl =
    let
      inherit (pkgs) libnotify brightnessctl;
    in
    pkgs.writeShellScriptBin "lightctl" ''
      case "$1" in
      up)
        ${_ brightnessctl} -q s +"$2"%
        ;;
      down)
        ${_ brightnessctl} -q s "$2"%-
        ;;
      esac

      brightness_percentage=$((($(${_ brightnessctl} g) * 100) / $(${_ brightnessctl} m)))
      ${libnotify}/bin/notify-send --transient \
        -u normal \
        -a "LIGHTCTL" \
        -h string:x-canonical-private-synchronous:lightctl \
        -h int:value:"$brightness_percentage" \
        -i display-brightness-symbolic \
        "LIGHTCTL" "Brightness: $brightness_percentage%"
    '';
in
{
  imports = [
    ./config
  ];

  home = {
    packages = with pkgs; [
      brightnessctl
      cliphist
      dbus
      glib
      grim
      gtk3
      libcanberra-gtk3
      libnotify
      pamixer
      sassc
      slurp
      wf-recorder
      wl-clipboard
      brillo
      wlr-randr
      wtype
      ydotool
      wlprop
      swaybg
      xorg.xprop

      ocrScript
      volumectl
      lightctl
    ] ++ lib.optional cfg pkgs.labwc;

    sessionVariables = {
      XDG_SESSION_DESKTOP = "wlr";
      QT_QPA_PLATFORM = "wayland";
      QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
      SDL_VIDEODRIVER = "wayland";
      CLUTTER_BACKEND = "wayland";
      GDK_BACKEND = "wayland,x11";
      XDG_SESSION_TYPE = "wayland";
      MOZ_ENABLE_WAYLAND = "1";
      QT_STYLE_OVERRIDE = lib.mkForce "kvantum";
    };
  };
}
