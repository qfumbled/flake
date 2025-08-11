{pkgs, ...}: {
  users.users.monaco = {
    isNormalUser = true;
    description = "monegasumes";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.nushell;
  };
}
