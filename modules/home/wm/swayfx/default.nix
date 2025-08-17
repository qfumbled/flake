{ config, inputs, lib, pkgs, ... }:

let
  inherit (lib) mkIf getExe;
  terminal = "foot";

  zellij-attach = pkgs.writeShellScriptBin "zellij-attach" ''
    #! /bin/sh
    session=$(zellij ls -sn | rofi -dmenu -theme ~/.config/rofi/config.rasi -p "zellij session:" )
    if [[ -z $session ]]; then
      exit
    fi
    ${terminal} -e zellij attach --create $session
  '';
in
{
  config = mkIf true {
    home = {
      packages = with pkgs; [
        libnotify
        wl-clipboard
      ];

      sessionVariables = {
        QT_QPA_PLATFORM = "wayland";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
        CLUTTER_BACKEND = "wayland";
        GDK_BACKEND = "wayland,x11";
        XDG_SESSION_TYPE = "wayland";
        MOZ_ENABLE_WAYLAND = "1";
        QT_STYLE_OVERRIDE = lib.mkForce "kvantum";
        TERMINAL = lib.mkForce terminal;
      };
    };

    wayland.windowManager.sway = {
      enable = true;
      systemd.enable = true;
      xwayland = true;
      checkConfig = false;
      package = inputs.swayfx.packages.${pkgs.system}.default;

      extraConfig = ''
        corner_radius 14
        shadows on
        shadow_offset 0 0
        shadow_blur_radius 20
        shadow_color #000000BB
        shadow_inactive_color #000000B0
        blur enable
        blur_xray disable
        default_dim_inactive 0.2
        layer_effects "notif" blur enable; shadows enable; corner_radius 20
        layer_effects "osd" blur enable; shadows enable; corner_radius 20
        layer_effects "work" shadows enable
        layer_effects "panel" shadows enable
        layer_effects "calendarbox" shadows enable; corner_radius 12

        for_window [app_id="spad"] move scratchpad, resize set width 900 height 600
        for_window [app_id="smusicpad"] move scratchpad, resize set width 850 height 550

        font pango:Product Sans 12
        titlebar_separator disable
        titlebar_padding 16
        title_align center
        default_border normal 2
        default_floating_border normal 2

        exec --no-startup-id swayidle -w \
            timeout 360 'waylock' \
            timeout 600 'swaymsg "output * power off"' resume 'swaymsg "output * power on"' \
            before-sleep 'waylock'
      '';

      config = {
        terminal = terminal;
        menu = "rofi -show drun";
        modifier = "Mod4";

        keybindings = {
          "print" = "exec 'grim -g \"$(slurp)\" - | wl-copy'";
          "Shift+print" = "exec 'grim - | wl-copy'";
          "XF86MonBrightnessUp" = "exec 'brightnessctl s 5+'";
          "XF86MonBrightnessDown" = "exec 'brightnessctl s 5-'";
          "XF86AudioRaiseVolume" = "exec 'pamixer -u ; pamixer -i 5'";
          "XF86AudioLowerVolume" = "exec 'pamixer -u ; pamixer -d 5'";
          "XF86AudioMute" = "exec 'pamixer -t'";
          "${config.wayland.windowManager.sway.config.modifier}+Return" = "exec ${terminal}";
        };

        input = {
          "type:touchpad" = {
            tap = "enabled";
            natural_scroll = "enabled";
          };
          "*" = {
            xkb_layout = "us";
            xkb_options = "grp:win_space_toggle,compose:ralt";
          };
        };

        output = {
          "DVI-D-1" = { resolution = "1920x1080"; position = "0,0"; };
          "HDMI-A-1" = { resolution = "1920x1080"; position = "1920,0"; };
        };

        gaps = {
          inner = 5;
          outer = 5;
        };

        bars = [ ];
      };
    };
  };
}
