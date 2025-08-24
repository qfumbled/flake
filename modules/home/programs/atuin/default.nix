{ config, pkgs, ... }:

{
  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    settings = {
      style = "compact";
      show_tabs = false;
      show_help = false;
      enter_accept = true;
    };
  };
}
