{ inputs, config, lib, ... }:

let
  generalSettings = with config.lib.stylix.colors; {
    gaps_in = 8;
    gaps_out = 12;
    border_size = 2;
    "col.inactive_border" = lib.mkForce "rgb(66858f)";
    "col.active_border" = lib.mkForce "rgb(66858f)";
    layout = "dwindle";
    resize_on_border = "true";
  };

  shadowSettings = {
    enabled = true;
    range = 18;
    render_power = 3;
    color = lib.mkForce "rgba(00000066)";
  };
in
{
  wayland.windowManager.hyprland = {
    settings = {
      env = [
        # "HYPRCURSOR_THEME,YourCursorThemeHere"
        "HYPRCURSOR_SIZE,24"
      ];
      general = generalSettings;
      decoration = {
        shadow = shadowSettings;
        rounding = 5;
        dim_inactive = true;
        dim_strength = 0.05;
      };
    };
  };
}
