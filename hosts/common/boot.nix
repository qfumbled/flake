{ pkgs, ... }: {
  boot.bootspec.enable = true;
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  tmp = {
    useTmpfs = true;
    cleanOnBoot = true;
  };

  plymouth.enable = true;

  initrd.systemd.enable = true;
  initrd.verbose = false;
  consoleLogLevel = 3;

  kernel.sysctl = {
    "net.isoc" = true;
    "kernel.kptr_restrict" = 1;
    "kernel.dmesg_restrict" = 1;

    "vm.swappiness" = 10;  # More aggressive swapping
    "vm.vfs_cache_pressure" = 50;  # Adjusting virtual filesystem cache
    "vm.dirty_ratio" = 10;  # Ratio of system memory used for dirty pages
    "vm.dirty_background_ratio" = 5;  # Background dirty pages threshold

    "kernel.nmi_watchdog" = 0;  # Disabling NMI watchdog
  };

  # Set TMPDIR for nix-daemon service
  systemd.services.nix-daemon = {
    environment = {
      TMPDIR = "/var/tmp";
    };
  };

  # Kernel boot parameters
  kernelParams = [
    "quiet"  # Suppress kernel messages during boot
    "splash"  # Show splash screen (Plymouth)
    "fastboot"  # Speed up the boot process
    "udev.log_priority=3"  # Log udev events with normal priority
    "rd.systemd.show_status=auto"  # Show systemd status during boot
    "rootfstype=xfs"  # Set root filesystem type to XFS
    "module.sig_enforce=1"  # Enforce module signature checking
    "lockdown=confidentiality"  # Enforce lockdown mode to secure the kernel
    "nvme.noacpi=1"  # Disable ACPI for NVMe devices (useful for some systems)
    "intel_iommu=on"  # Enable Intel IOMMU for PCI passthrough (useful for VMs)
    "amd_iommu=on"  # Enable AMD IOMMU (useful for VMs)
    "amd_pstate=active"  # Force AMD power state driver to active mode for performance

    "ideapad_laptop.allow_v4_dytc=Y"  # Enable dynamic thermal control for Lenovo Ideapad laptops
    "nvme_core.default_ps_max_latency_us=0"  # Set maximum power state latency for NVMe drives to 0
  ];

  # EFI System Partition mount point
  efi.efiSysMountPoint = "/boot";  # Mount point for the EFI partition
}
