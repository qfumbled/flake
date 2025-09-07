{
  pkgs,
  username,
  ...
 }:
{
  users = {
    users.${username} = {
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
    defaultUserShell = pkgs.fish;
  };
}
