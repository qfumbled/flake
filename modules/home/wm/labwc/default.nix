{ pkgs, lib, config, ... }:

let
  cfg = config.meadow.default.wm == "labwc";
in
{
  imports = [ ./config ];

  home.packages = with pkgs; [
    swaybg
  ] ++ lib.optional cfg labwc;  # include labwc only if cfg is true
}
