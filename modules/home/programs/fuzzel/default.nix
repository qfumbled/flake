{ config, lib, ... }: let
  colors = config.lib.stylix.colors.withHashtag;
in {
  programs.fuzzel.enable = true;
  programs.fuzzel.settings = {
    main = {
      font = "Rubik:size=10";
      horizontal-pad = 18;
      vertical-pad = 18;
      inner-pad = 18;
      dpi-aware = "no";
      icons-enabled = "no";
      line-height = 20;
      lines = 8;
    };
    border = {
      radius = 0;
      width = 2;
    };
    colors = {
      background = "${colors.base00}ff";
      text = "${colors.base05}ff";
      selection-text = "${colors.base05}ff";
      match = "${colors.base0D}ff";
      prompt = "${colors.base0D}ff";
      input = "${colors.base05}ff";
      placeholder = "${colors.base03}ff";
      selection-match = "${colors.base0D}ff";
      selection = "${colors.base02}ff";
      border = "${colors.base01}ff";
    };
  };
}
