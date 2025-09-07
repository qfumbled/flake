{ 
  pkgs,
  config,
  lib,
  ...
}:

let
  inherit (lib) mkIf mkEnableOption;
  cfgTailscale = config.meadow.programs.tailscale;
  cfgWayland   = config.meadow.programs.wayland;
in
{
  imports = lib.meadow.readSubfiles ./. [ "default.nix" ];

  options.meadow.programs = {
    tailscale.enable = mkEnableOption "tailscale";
    wayland.enable   = mkEnableOption "wayland";
  };

  config = {
    i18n = {
      defaultLocale = "en_CA.UTF-8";
    };

    console.keyMap = "us";

    system.stateVersion = lib.mkDefault "24.11";

    system = {
      copySystemConfiguration = false;
      switch.enable = true;
      rebuild.enableNg = true;
    };

    time = {
      timeZone = "America/Tornoto";
      hardwareClockInLocalTime = true;
    };

    zramSwap = {
      enable        = true;
      algorithm     = "zstd";
      memoryPercent = 25;
    };

    environment.systemPackages = with pkgs; [
      dconf
      bat
      blueman
      btop
      brightnessctl
      dig
      dosis
      comma
      ffmpeg_7-full
      git
      git-extras
      gnu-config
      gnupg
      grim
      gtk3
      home-manager
      kanata
      lix-diff
      lua-language-server
      lua54Packages.lua
      mpv
      ncdu
      nix-prefetch-git
      nodejs
      obs-studio
      pamixer
      procps
      pulseaudio
      python3
      ripgrep
      sd
      slack
      slack-term
      slop
      spotify
      srt
      unzip
      wget
      wirelesstools
      xdg-utils
      yaml-language-server
      yq
      (mkIf cfgTailscale.enable tailscale)
      (mkIf cfgWayland.enable wayland)
    ];
  };
}
