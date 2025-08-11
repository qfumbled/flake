{
  pkgs,
  config,
  lib,
  ...
}: let
  inherit (lib) mkIf mkEnableOption;
  cfgTailscale = config.programs.tailscale;
  cfgWayland = config.programs.wayland;
in {
  options.programs = {
    tailscale.enable = mkEnableOption "tailscale";
    wayland.enable = mkEnableOption "wayland";
  };

  config = {
    environment.systemPackages = with pkgs; [
      spotify
      lix-diff
      obs-studio
      git
      git-extras
      brightnessctl
      bat
      pamixer
      pulseaudio
      cachix
      yq
      srt
      (mkIf cfgTailscale.enable tailscale)
      unzip
      (mkIf cfgWayland.enable wayland)
      wget
      wirelesstools
      xdg-utils
      yaml-language-server
      yq
    ];
  };
}
