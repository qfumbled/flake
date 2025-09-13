{
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    ../shared
  ];

  networking = {
    hostName = "keven";
  };

  system = {
    stateVersion = "23.11"; # Did you read the comment? no
  };
}
