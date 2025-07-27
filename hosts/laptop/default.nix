{ config, pkgs, lib, ... }: {
  imports = [
    ../common
    /etc/nixos/hardware-configuration.nix
    ./networking.nix
    ./users.nix
    ./boot.nix
    ./lanzaboote.nix
  ];

  # Swap Devices
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 24 * 1024; # Size in MiB (24 GiB)
    }
  ];

  zramSwap.enable = true;
  
  services = {
    fstrim.enable = true;
    scx = {
      enable = true;
      scheduler = "scx_rusty";
    };
  };

  environment.systemPackages = [ config.boot.kernelPackages.cpupower ];

  systemd.services.nix-daemon.environment = {
    TMPDIR = "/var/tmp";  # Ensuring TMPDIR for nix-daemon
  };

  boot = {
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth.enable = true;

    kernelModules = [
      "v4l2loopback"
      "i2c-dev"
    ];

    initrd.systemd.enable = true;

    supportedFilesystems = [ "ntfs" ];

    extraModulePackages = with config.boot.kernelPackages; [ v4l2loopback ];

    kernelParams = [
      "intel_pstate=active"  # Use Intel CPU P-state driver
      "intel_iommu=on"  # Enable IOMMU for Intel processors
      "mitigations=off"  # Optionally disable mitigations for performance (use with caution)
      "ideapad_laptop.allow_v4_dytc=Y"  # Specific to some Lenovo devices
      "nvme_core.default_ps_max_latency_us=0"  # NVMe latency tuning
    ];

    kernel.sysctl = {
      "vm.swappiness" = 10;
      "vm.vfs_cache_pressure" = 50;
      "vm.dirty_ratio" = 10;
      "vm.dirty_background_ratio" = 5;
      "kernel.nmi_watchdog" = 0;
    };

    extraModprobeConfig = ''
      options v4l2loopback exclusive_caps=1 card_label="OBS Virtual Output"
    '';

    tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };
  };

  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };

  users.users = {
    dulish = {
      extraGroups = [ "tss" ];
    };
  };
}
