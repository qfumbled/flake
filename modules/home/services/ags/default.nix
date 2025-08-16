{
  pkgs,
  lib,
  inputs,
  config,
  ...
}:

{
  imports = [ inputs.ags.homeManagerModules.default ];

  home.file.".config/ags_res/colors.scss".text = with config.lib.stylix.colors.withHashtag; ''
    $ac-red: ${base08};
    $ac-green: ${base0B};
    $ac-yellow: ${base0A};
    $ac-blue: ${base0D};
    $ac-magenta: ${base0E};
    $ac-cyan: ${base0C};
    $ac-orange: ${base09};

    $bg: ${base01};
    $bg-alt: ${base02};
    $bg-urg: ${base00};
    $fg-alt: ${base03};
    $fg: ${base05};
    $ac: $ac-blue;
  '';

  home.packages = with pkgs; [
    inputs.astal.packages.${system}.default
    dart-sass
    pavucontrol
    procps
    gjs
    inputs.ags.packages.${pkgs.system}.io
  ];

  programs.ags = {
    enable = true;
    extraPackages = with inputs.ags.packages.${pkgs.system}; [
      pkgs.gtk-session-lock
      auth
      battery
      hyprland
      mpris
      network
      tray
      wireplumber
      bluetooth
      notifd
      apps
    ];
  };
}
