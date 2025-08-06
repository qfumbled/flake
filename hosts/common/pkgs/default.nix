{ pkgs, config, lib, ... }:

let
  inherit (lib) mkIf mkEnableOption;
  cfgTailscale = config.programs.tailscale;
  cfgWayland = config.programs.wayland;
in
{
  options.programs = {
    tailscale.enable = mkEnableOption "tailscale";
    wayland.enable = mkEnableOption "wayland";
  };

  config = {
    system.activationScripts.diff = {
      text = ''
        if [[ -e /run/current-system ]]; then
          echo "=== diff to current-system ==="
          ${lib.getExe pkgs.lix-diff} --lix-bin ${config.nix.package}/bin /run/current-system "$systemConfig"
          echo "=== end of the system diff ==="
        fi
      '';
    };

    environment.systemPackages = with pkgs; [
      spotify
      lix-diff
      obs-studio
      git
      git-extras
      brightnessctl
      blueman
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
