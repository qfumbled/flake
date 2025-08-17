{ config, pkgs, lib, ... }:

let
  mkForce = lib.mkForce;
in
{
  wayland.windowManager.hyprland.settings = {
    exec-once = [
      "clipse -listen"
      "wl-paste --type text --watch cliphist store"
      "wl-paste --type image --watch cliphist store"
      "xprop -root -f _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 1"
      "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      "systemctl --user import-environment PATH"
      "systemctl --user restart xdg-desktop-portal.service"
      "systemctl --user restart xdg-desktop-portal-wlr.service"
    ];

    general = {
      gaps_in = "8";
      gaps_out = "12";
      border_size = "0";
      layout = "dwindle";
      resize_on_border = "true";

      # Hyprland wins conflicts
      "col.active_border" = mkForce "rgba(88888888)";
      "col.inactive_border" = mkForce "rgba(00000088)";

      allow_tearing = true;
    };

    decoration = {
      rounding = "6";
      inactive_opacity = "0.94";

      blur = {
        enabled = "yes";
        size = "3";
        passes = "4";
        new_optimizations = "on";
        ignore_opacity = "on";
        xray = "false";
      };
    };

    dwindle = {
      pseudotile = true;
      preserve_split = true;
    };

    env = [
      "GDK_SCALE,1"
      "WLR_DRM_NO_ATOMIC,1"
    ];

    gestures.workspace_swipe = true;

    input = {
      kb_layout = "us";
      kb_options = "compose:rctrl,caps:escape";
      accel_profile = "flat";
      follow_mouse = 1;

      touchpad = {
        disable_while_typing = true;
        natural_scroll = true;
        scroll_factor = 0.8;
      };
    };

    misc = {
      enable_swallow = true;
      swallow_regex = "nemo|wezterm|waybar";
      disable_autoreload = false;
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      focus_on_activate = true;
      force_default_wallpaper = 0;
      key_press_enables_dpms = true;
      mouse_move_enables_dpms = true;
      vfr = true;
      vrr = 1;
    };

    monitor = [
      "eDP-1, highres, 0x0, 1"
    ];

    xwayland.force_zero_scaling = true;
  };

  home.sessionVariables.XDG_SESSION_DESKTOP = mkForce "Hyprland";
}
