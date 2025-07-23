{pkgs, ...}: {
  users.users.xoc = {
    isNormalUser = true;
    description = "wien";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.nushell;
  };
}
