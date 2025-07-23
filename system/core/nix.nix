{ config, pkgs, ... }:

{
  programs.nix-ld = {
    enable = true;
    package = pkgs.nix-ld-rs;
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 2d";
    dates = "22:30";
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = ["root" "@wheel"];
    trusted-substituters = [
      "https://cache.nixos.org/"
      "http://192.168.1.144:5000"
    ];
    trusted-public-keys = [
      "binarycache.example.com:bFHgI8jFAA6AoHIKc244zm+HuvjPitj759k/Pr9WNvQ="
    ];
    keep-outputs = true;
    keep-derivations = true;
    auto-optimise-store = true;
    warn-dirty = false;
  };

  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = true;
      allowUnfreePredicate = _: true;
    };
  };
}
