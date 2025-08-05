{lib, ...}: {
  services.displayManager.sddm.enable = lib.mkForce false;
}
