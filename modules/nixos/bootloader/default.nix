{
  config,
  pkgs,
  ...
}: {
 boot = {
    bootspec.enable = true;

    initrd.systemd.enable = true;
    supportedFilesystems = [ "ntfs" ];

    kernelPackages = pkgs.linuxPackages_latest;

    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "systemd.show_status=auto"
      "rd.udev.log_level=3"
      "plymouth.use-simpledrm"
    ];

    loader = {
      systemd-boot.enable = lib.mkForce false;
    };

    limine = {
      enable = true;
      efiSupport = true;
      style.wallpapers = [
        pkgs.nixos-artwork.wallpapers.simple-dark-gray-bootloader.gnomeFilePath
      ];
      maxGenerations = 10;
      secureBoot.enable = true;
    };

    plymouth.enable = true;

    tmp.useTmpfs = true;
    tmp.cleanOnBoot = true;
  };

  systemd.services.nix-daemon = {
    environment = {
      TMPDIR = "/var/tmp";
    };
  };

  environment.systemPackages = [
    config.boot.kernelPackages.cpupower
    pkgs.sbctl
  ];
}
