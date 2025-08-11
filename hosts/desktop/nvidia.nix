{...}: {
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [
    "nvidia"
  ];
  hardware.nvidia.open = false;
  hardware.nvidia.modesetting.enable = true;
}
