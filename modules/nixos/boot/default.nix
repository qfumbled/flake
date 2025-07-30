{ config, pkgs, ... }: {
  boot = {
    kernelPackages = pkgs.linuxPackages_cachyos;
    tmp.cleanOnBoot = true;
    supportedFilesystems = [ "ntfs" ];

    loader = {
      timeout = 2;
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    plymouth.enable = true; 
  };
}
