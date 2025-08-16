{ config, pkgs, ... }:

let
  makeCommand = command: { command = [command]; };

  colors = {
    base00 = "#f5f3ef";
    base01 = "#e6e5e4";
    base02 = "#cccbca";
    base03 = "#b3b2b1";
    base04 = "#999898";
    base05 = "#5c5c5c";
    base06 = "#5c5c5c";
    base07 = "#5c5c5c";
    base08 = "#b66467";
    base09 = "#b88757";
    base0A = "#b88757";
    base0B = "#76b05c";
    base0C = "#7d9ea7";
    base0D = "#66858f";
    base0E = "#9661cc";
    base0F = "#aaa9a9";
  };
in
{
  programs.niri = {
    enable = true;
    package = pkgs.niri;

    settings = {
      environment = {
        CLUTTER_BACKEND = "wayland";
        DISPLAY = null;
        GDK_BACKEND = "wayland,x11";
        MOZ_ENABLE_WAYLAND = "1";
        NIXOS_OZONE_WL = "1";
        QT_QPA_PLATFORM = "wayland;xcb";
        QT_WAYLAND_DISABLE_WINDOWDECORATION = "1";
        SDL_VIDEODRIVER = "wayland";
      };

      spawn-at-startup = [
        (makeCommand "hyprlock")
        { command = ["wl-paste" "--watch" "cliphist" "store"]; }
        { command = ["wl-paste" "--type" "--watch" "cliphist" "store"]; }
      ];

      input = {
        keyboard.xkb.layout = "us";

        touchpad = {
          click-method = "button-areas";
          dwt = true;
          dwtp = true;
          natural-scroll = true;
          scroll-method = "two-finger";
          tap = true;
          tap-button-map = "left-right-middle";
          middle-emulation = true;
          accel-profile = "adaptive";
        };

        focus-follows-mouse = {
          enable = true;
          max-scroll-amount = "90%";
        };

        warp-mouse-to-focus.enable = true;
        workspace-auto-back-and-forth = true;
      };

      screenshot-path = "~/Pictures/Screenshots/Screenshot-from-%Y-%m-%d-%H-%M-%S.png";

      outputs = {
        "eDP-1" = { scale = 1.0; position = { x = 0; y = 0; }; };
        "HDMI-A-1" = {
          mode = { width = 1920; height = 1080; refresh = null; };
          scale = 1.0;
          position = { x = 0; y = -1080; };
        };
      };

      overview = {
        workspace-shadow.enable = false;
        backdrop-color = colors.base00;
      };

      gestures = { hot-corners.enable = true; };

      layout = {
        focus-ring.enable = false;
        shadow.enable = false;
        border = {
          enable = true;
          width = 4;
          active.color = colors.base0E;   # purple
          inactive.color = colors.base03; # gray
        };


        preset-column-widths = [
          { proportion = 0.25; }
          { proportion = 0.5; }
          { proportion = 0.75; }
          { proportion = 1.0; }
        ];
        default-column-width = { proportion = 0.5; };

        gaps = 6;
        struts = { left = 0; right = 0; top = 0; bottom = 0; };

        tab-indicator = {
          hide-when-single-tab = true;
          place-within-column = true;
          position = "left";
          corner-radius = 20.0;
          gap = -12.0;
          gaps-between-tabs = 10.0;
          width = 4.0;
          length.total-proportion = 0.1;
        };
      };

      animations.window-resize.custom-shader = ''
        vec4 resize_color(vec3 coords_curr_geo, vec3 size_curr_geo) {
          vec3 coords_next_geo = niri_curr_geo_to_next_geo * coords_curr_geo;
          vec3 coords_stretch = niri_geo_to_tex_next * coords_curr_geo;
          vec3 coords_crop = niri_geo_to_tex_next * coords_next_geo;

          bool can_crop_by_x = niri_curr_geo_to_next_geo[0][0] <= 1.0;
          bool can_crop_by_y = niri_curr_geo_to_next_geo[1][1] <= 1.0;

          vec3 coords = coords_stretch;
          if (can_crop_by_x) coords.x = coords_crop.x;
          if (can_crop_by_y) coords.y = coords_crop.y;

          vec4 color = texture2D(niri_tex_next, coords.st);

          if (can_crop_by_x && (coords_curr_geo.x < 0.0 || 1.0 < coords_curr_geo.x))
            color = vec4(0.0);
          if (can_crop_by_y && (coords_curr_geo.y < 0.0 || 1.0 < coords_curr_geo.y))
            color = vec4(0.0);

          return color;
        }
      '';

      prefer-no-csd = true;
      hotkey-overlay.skip-at-startup = true;
    };
  };
}
