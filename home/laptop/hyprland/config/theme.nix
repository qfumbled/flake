{ inputs, config, lib, ... }:

{
  wayland.windowManager.hyprland = {
    settings = {
      # Set your own cursor theme here if you want
      env = [
        # "HYPRCURSOR_THEME,YourCursorThemeHere"
        "HYPRCURSOR_SIZE,24"
      ];

      general = with config.lib.stylix.colors; {
        gaps_in = 8;
        gaps_out = 12;
        border_size = 2;
        "col.inactive_border" = "rgb(${base01})";
        "col.active_border" = "rgb(${base01})";
        layout = "dwindle";
        resize_on_border = "true";
      };

      decoration = {
        shadow = {
          enabled = true;
          range = 18;
          render_power = 3;
          color = lib.mkForce "rgba(00000066)";
        };
        rounding = 5;
        dim_inactive = true;
        dim_strength = 0.05;
      };
    };
  };
}
