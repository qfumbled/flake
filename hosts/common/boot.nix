{pkgs, ...}: {
  boot = {
    # kernelPackages = pkgs.linuxPackages_cachyos; # till you install the flake
    kernelPackages = pkgs.linuxPackages_latest;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 15;
    };

    plymouth = {
      enable = false;
    };

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];

    initrd.verbose = false;
    consoleLogLevel = 3;
  };
}
