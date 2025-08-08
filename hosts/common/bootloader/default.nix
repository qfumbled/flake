{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_hardened;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 15;
    };

    plymouth.enable = false;

    kernelModules = ["v4l2loopback"];
    extraModulePackages = [config.boot.kernelPackages.v4l2loopback];
    kernelParams = [
      "quiet"
      "splash"
      "fastboot"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
      "rootfstype=xfs"
      "module.sig_enforce=1"
      "lockdown=confidentiality"
    ];

    initrd.verbose = false;
    consoleLogLevel = 3;

    kernel.sysctl = {
      "kernel.kptr_restrict" = 1;
      "kernel.dmesg_restrict" = 1;
    };
  };
}
