{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_hardened;

    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      timeout = 15;
    };

    plymouth.enable = false;

    kernelParams = [
      "quiet"
      "splash"
      "fastboot"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"

      # Security hardening
      "lockdown=confidentiality" # Lock kernel from runtime modifications
      "module.sig_enforce=1" # Require signed kernel modules
      "rootfstype=xfs" # Limit FS to XFS
      "debugfs=off" # Disable debugfs
      "oops=panic" # Panic on kernel oops
      "panic_on_oops=1" # Force immediate panic
      "module_blacklist=cramfs,freevxfs,hfs,hfsplus,udf,ufs" # Disable unused FS
    ];

    initrd.verbose = false;
    consoleLogLevel = 3;

    kernel.sysctl = {
      "kernel.kptr_restrict" = 2;
      "kernel.dmesg_restrict" = 1;
      "kernel.unprivileged_bpf_disabled" = 1;
    };
  };
}
