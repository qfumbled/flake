{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./modules
  ];

  programs = {
    home-manager.enable = true;
    btop.enable = true;
    zathura.enable = true;
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true;
  };

  home = {
    username = "wug";
    homeDirectory = "/home/wug";

    # NOTE: Do not change
    stateVersion = "23.11";

    packages = with pkgs; [
      nemo-with-extensions
      niri
      swayimg
      mpv
      htop
      obsidian
      pavucontrol
      obs-studio
      rnote
      typst
      blueman
      freshfetch     
      app2unit
      asciinema_3
      bruno
      charm
      charm-freeze
      circumflex
      clipse
      colordiff
      deadnix
      delta
      docker-compose
      doggo
      eza
      fd
      feh
      fx
      fzf
      gcc
      gh
      git-absorb
      glow
      gnumake
      gping
      grimblast
      gum
      helmfile
      httpie
      imagemagick
      inotify-tools
      jq
      jqp
      just
      k9s
      keybase
      kubecolor
      kubectl
      kubectx
      kubernetes-helm
      light
      magic-wormhole
      material-symbols
      networkmanagerapplet
      nh
      nix-fast-build
      nix-inspect
      nix-output-monitor
      nix-search-tv
      nix-update
      nixfmt-rfc-style
      onefetch
      openssl
      opkssh
      pavucontrol
      pfetch
      pgcli
      pinentry
      playerctl
      pre-commit
      presenterm
      python312Packages.gst-python
      python312Packages.materialyoucolor
      python312Packages.pillow
      python312Packages.pip
      python312Packages.pygobject3
      python312Packages.setuptools
      python312Packages.virtualenv
      satty
      slides
      sops
      starship
      stern
      syncthing
      television
      tldr
      up
      vegeta
      viddy
      vlc
      wireplumber
      xdotool
      xwayland
    ];
    sessionVariables = {
      EDITOR = "hx";
      TERMINAL = "foot";
    };
  };
}
