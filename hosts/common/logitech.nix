{
  config,
  pkgs,
  ...
}: {
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };
}
