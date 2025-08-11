{ pkgs, ... }: {
  boot = {
    # Define the kernel and related options
    kernelPackages = pkgs.linuxPackages_latest;

    # Enable bootspec (e.g., specifying a bootloader)
    bootspec.enable = true;

    loader = {
      # Enable systemd-boot as the bootloader
      systemd-boot.enable = true;
      efi.efiSysMountPoint = "/boot";
      efi.canTouchEfiVariables = true;
      timeout = 15;
    };

    # Use tmpfs for /tmp
    tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };

    # Enable Plymouth for boot splash screen
    plymouth.enable = true;

    # Kernel modules
    kernelModules = ["v4l2loopback"];
    extraModulePackages = [pkgs.linuxPackages_latest.v4l2loopback];

    # Kernel parameters to pass during boot
    kernelParams = [
      "quiet"
      "splash"
      "fastboot"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
      "rootfstype=xfs"
      "module.sig_enforce=1"
      "lockdown=confidentiality"
      "nvme.noacpi=1"
      "intel_iommu=on"
      "amd_iommu=on"
      "amd_pstate=active"
      "ideapad_laptop.allow_v4_dytc=Y"
      "nvme_core.default_ps_max_latency_us=0"
    ];

    # Configure initrd
    initrd.systemd.enable = true;
    initrd.verbose = false;

    # Log levels
    consoleLogLevel = 3;

    # Sysctl configurations (kernel parameters after boot)
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

  # Systemd service configuration for nix-daemon
  systemd.services.nix-daemon = {
    environment = {
      TMPDIR = "/var/tmp";
    };
  };
}
