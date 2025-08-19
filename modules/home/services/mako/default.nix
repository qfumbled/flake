{ config, ... }:

let
  colors = config.lib.stylix.colors;
in
{
  services.mako = {
    enable = true;
    settings = {
      sort             = "-time";
      layer            = "overlay";
      background-color = "#${colors.base00}";
      text-color       = "#${colors.base05}";
      border-color     = "#${colors.base0D}";
      width            = 200;
      height           = 300;
      padding          = 12;        # number, not string
      border-size      = 2;         # number, not string
      border-radius    = 0;
      markup           = true;
      icons            = true;
      format           = ''%s\n\n%b'';
      actions          = true;
      max-icon-size    = 32;
      default-timeout  = null;      # null = persistent
      ignore-timeout   = true;
      font             = "Rubik 9";

      "urgency=low" = {
        border-color = "#${colors.base0B}";
      };
      "urgency=normal" = {
        border-color = "#${colors.base01}";
      };
      "urgency=high" = {
        border-color = "#${colors.base08}";
      };
      "actionable" = {
        format = ''%s\n\n%b\n\nM-O to view actions'';
      };
    };
  };
}
