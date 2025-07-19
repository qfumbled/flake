{pkgs, ...}: {
  users.users.wien = {
    isNormalUser = true;
    description = "wien";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.nushell;
  };
}
