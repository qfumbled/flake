{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_hardened;

    loader = {
      systemd-boot.enable = true;
      efi.efiSysMountPoint = "/boot";
      efi.canTouchEfiVariables = true;
      timeout = 15;
    };

    plymouth.enable = true;
    kernelModules = ["v4l2loopback"];
    extraModulePackages = [pkgs.linuxPackages_hardened.v4l2loopback];
    kernelParams = [
      "quiet"
      "splash"
      "fastboot"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
      "rootfstype=xfs"
      "module.sig_enforce=1"
      "lockdown=confidentiality"
      "mitigations=on"
      "ideapad_laptop.allow_v4_dytc=Y"
      "nvme_core.default_ps_max_latency_us=0"
    ];

    initrd.verbose = false;
    consoleLogLevel = 3;

    kernel.sysctl = {
      "net.isoc" = true;
      "kernel.kptr_restrict" = 1;
      "kernel.dmesg_restrict" = 1;

      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_ratio" = 10;
      "vm.dirty_background_ratio" = 5;

      "kernel.nmi_watchdog" = 0;
    };
  };
}
