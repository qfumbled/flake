{
  pkgs,
  ...
 }:
{
  users = {
    users.wug = {
      isNormalUser = true;
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
    };
    defaultUserShell = pkgs.mksh;
  };
}
