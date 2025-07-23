{ config, pkgs, lib, ... }: {
  services = {
    fstrim.enable = true;

    scx = {
      enable = true;
      scheduler = "scx_rusty";
    };
  };

  environment.systemPackages = [ config.boot.kernelPackages.cpupower ];

  systemd.services.nix-daemon.environment = {
    TMPDIR = "/var/tmp";
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
      "amd_pstate=active"
      "amd_iommu"
      "mitigations=off"
      "ideapad_laptop.allow_v4_dytc=Y"
      "nvme_core.default_ps_max_latency_us=0"
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
    xoc = {
      extraGroups = [ "tss" ];
    };
  };
}
