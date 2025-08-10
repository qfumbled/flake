{ inputs, config, lib, ... }:

let
  # Define shadow settings in one place
  shadowSettings = {
    enabled = true;
    range = 18;
    render_power = 3;
    # Force this color to avoid conflicting definitions
    color = lib.mkForce "rgba(00000066)";
  };

  generalSettings = with config.lib.stylix.colors; {
    gaps_in = 8;
    gaps_out = 12;
    border_size = 2;
    "col.inactive_border" = "rgb(${base01})";
    "col.active_border" = "rgb(${base01})";
    layout = "dwindle";
    resize_on_border = "true";
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
