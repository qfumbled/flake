{...}: {
  nix.settings.experimental-features = ["nix-command" "flakes"];
  services.printing.enable = true;

  system.stateVersion = "25.05";
}
