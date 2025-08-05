{pkgs, ...}: {
  users.users.poacher = {
    isNormalUser = true;
    description = "Henry M.";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.nushell;
  };
}
