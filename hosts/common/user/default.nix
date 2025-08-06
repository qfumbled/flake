{pkgs, ...}: {
  users.users.monaco = {
    isNormalUser = true;
    description = "monegasque";
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.nushell;
  };
}
