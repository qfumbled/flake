{
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../shared
  ];

  systemd.tpm2.enable = false;

  networking = {
    hostName = "kevnet";
  };

  hardware = {
    ckb-next.enable = true;
  };

  system = {
    stateVersion = "23.11"; # Did you read the comment?
  };

  environment.systemPackages = [
    pkgs.ntfs3g
  ];
}
