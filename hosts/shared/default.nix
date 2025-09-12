{
  pkgs,
  ...
}:

{
  imports = [
    ./stylix
    ./hardware
    ./security.nix
    ./users.nix
    ./boot.nix
    ./network
  ];

  theme.stylix = {
    polarity = "dark";
    themeName = "cyberdream";
  };

  networking.networkmanager = {
    enable = true;
    appendNameservers = [
      "1.1.1.1"
    ];
  };

 system = {
      copySystemConfiguration = false;
      switch.enable = true;
      rebuild.enableNg = true;
    };


  # Sorry for being Canadian
  time.timeZone = "America/Toronto";

  i18n.defaultLocale = "en_CA.UTF-8";

  services.xserver = {
    xkb = {
      layout = "us";
      variant = "";
    };
  };

  security.rtkit.enable = true;

  virtualisation.docker.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  environment.systemPackages = with pkgs; [
    wget
    curl
    git
    pamixer
    libnotify
    wl-clipboard
    ripgrep
    freshfetch
    unzip
    killall
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      noto-fonts-color-emoji
      liberation_ttf
      dejavu_fonts
      rubik
      pkgs.nerd-fonts.roboto-mono
      font-awesome
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [
          "DejaVu Sans"
          "Noto Sans CJK"
        ];
        serif = [
          "DejaVu Serif"
          "Noto Serif CJK"
        ];
        monospace = [
          "DejaVu Sans Mono"
          "Noto Sans Mono CJK"
        ];
      };
    };
  };

  programs.dconf.enable = true;

  services = {
    upower.enable = true;
    gvfs.enable = true;
  };
    zramSwap = {
      enable        = true;
      algorithm     = "zstd";
      memoryPercent = 25;
    };

  environment.shells = [
    pkgs.mksh
  ];

  environment.sessionVariables = {
    EDITOR = "nvim";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
    };
  };
}
