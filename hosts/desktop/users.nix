{pkgs, ...}: {
  users.users.dulish = {
    isNormalUser = true;
    description = "wien";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.nushell;
  };
}
