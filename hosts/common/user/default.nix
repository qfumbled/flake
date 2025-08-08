{pkgs, ...}: {
  users.users.monaco = {
    isNormalUser = true;
    description = "monegasque";
    extraGroups = [
      "wheel"
      "networkmanager"
      "audio"
      "video"
      "libvirtd"
      "docker"
      "uinput"
      "adbusers"
    ];
    shell = pkgs.nushell;
  };
}
