{ config, pkgs, lib, ... }:

let
  inherit (lib) mkIf mkEnableOption;
  cfg = config.meadow.services.mako;

  colors = config.lib.stylix.colors;
  mkF = pkgs.lib.mkForce;  # always use pkgs.lib.mkForce
in
{
  options.meadow.services.mako.enable = mkEnableOption "mako";

  config = mkIf cfg.enable {
    services.mako = {
      enable = true;
      settings = mkF {
        sort             = mkF "-time";
        layer            = mkF "overlay";
        background-color = mkF "#${colors.base00}";
        text-color       = mkF "#${colors.base05}";
        border-color     = mkF "#${colors.base0D}";
        width            = mkF 200;
        height           = mkF 300;
        padding          = mkF 12;
        border-size      = mkF 2;
        border-radius    = mkF 0;
        markup           = mkF true;
        icons            = mkF true;
        format           = mkF ''%s\n\n%b'';
        actions          = mkF true;
        max-icon-size    = mkF 32;
        default-timeout  = mkF null;
        ignore-timeout   = mkF true;
        font             = mkF "Rubik 9";

        "urgency=low" = mkF {
          border-color = mkF "#${colors.base0B}";
        };
        "urgency=normal" = mkF {
          border-color = mkF "#${colors.base01}";
        };
        "urgency=high" = mkF {
          border-color = mkF "#${colors.base08}";
        };
        "actionable" = mkF {
          format = mkF ''%s\n\n%b\n\nM-O to view actions'';
        };
      };
    };
  };
}
