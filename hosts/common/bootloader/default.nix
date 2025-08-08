{pkgs, ...}: {
  boot = {
    boot.kernelPackages = pkgs.linuxPackages_hardened;
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
      "fastboot"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
    ];

    initrd.verbose = false;
    consoleLogLevel = 3;
  };
}
