{ config, pkgs, lib, ... }:

let
  colors = config.lib.stylix.colors.withHashtag;
in
{
  programs.waybar = {
    enable = true;
    settings = [
      {
        layer = "top";
        position = "bottom";
        height = 36;
        spacing = 8;
        modules-left = ["clock"];
        modules-center = ["wlr/taskbar"];
        modules-right = ["tray" "battery" "wireplumber" "network"];

        clock = {
          tooltip = false;
          interval = 60;
          format = "{:%H:%M}";
          max-length = 25;
        };

        "wlr/taskbar" = {
          format = "{app_id}";
          on-click = "minimize-raise";
        };

        tray = {
          icon-size = 12;
          spacing = 8;
        };

        battery = {
          interval = 3;
          states = {
            warning = 30;
            critical = 15;
          };
          format-icons = [" " " " " " " " " "];
          format = "{icon} {capacity}%";
          format-charging = "{icon} {capacity}%";
          max-length = 25;
        };

        wireplumber = {
          format-icons = [" " " " " "];
          format = "{icon} {volume}%";
          format-muted = "  {volume}%";
          on-click = "${pkgs.pamixer}/bin/pamixer --toggle-mute";
        };

        network = {
          format = "{ifname}";
          format-wifi = "{essid}";
          format-ethernet = "Wired";
          format-disconnected = "Disconnected";
          tooltip-format = "{ifname} via {gwaddr}";
          tooltip-format-wifi = "{essid} ({signalStrength}%)";
          tooltip-format-ethernet = "Connected: Wired";
          tooltip-format-disconnected = "Disconnected";
          max-length = 50;
        };
      }
    ];

    style = ''
      *:not(separator) {
        all: unset;
        font-family: "Rubik", "Font Awesome 6 Free";
        font-size: 9pt;
      }

      /* Main Bar */
      window#waybar {
        background: ${colors.base00};
        border-top: 2px solid ${colors.base01};
        color: ${colors.base05};
      }

      window#waybar.hidden {
        opacity: 0.2;
      }

      .modules-left {
        margin-left: 0.5rem;
      }

      .modules-right {
        margin-right: 0.5rem;
      }

      menu {
        background: ${colors.base01};
        padding: 8px;
      }

      menu separator {
        background: ${colors.base03};
        margin: 0.4rem 0;
      }

      menu menuitem {
        color: ${colors.base05};
        padding: 0.8rem;
      }

      menu menuitem:hover {
        background: ${colors.base02};
      }

      tooltip {
        background: ${colors.base01};
        color: ${colors.base05};
      }

      tooltip label {
        margin: 0.8rem;
      }

      #clock,
      #taskbar,
      #tray,
      #battery,
      #wireplumber,
      #network {
        margin: 0.5rem;
      }

      #taskbar button {
        padding: 0 0.8rem;
        margin: 0 0.4rem;
      }

      #taskbar:first-child {
        margin-left: 0;
      }

      #taskbar:last-child {
        margin-right: 0;
      }

      #taskbar button:hover,
      #taskbar button.active {
        background: ${colors.base02};
      }
    '';
  };
}
