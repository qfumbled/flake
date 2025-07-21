{pkgs, ...}: {
  users.users.wien = {
    isNormalUser = true;
    description = "Alexander";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.nushell;
  };
}
