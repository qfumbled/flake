{
  config,
  lib,
  pkgs,
  ...
}: {
  nix = {
    gc.automatic = false;
    settings = {
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
    optimise.automatic = true;
    # Optional nixPath if you still need compatibility with old tools
    nixPath = [
      "nixpkgs=${pkgs.path}"
    ];
  };

  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      dates = "weekly";
      extraArgs = "--keep-since 7d";
    };
  };

  # Remove sourceInfo/self unless needed
  # system.extraSystemBuilderCmds = "ln -s ${self.sourceInfo.outPath} $out/src";

  # Clean nixos.label to avoid missing `self`
  system.nixos.label = lib.concatStringsSep "-" (
    (lib.sort (x: y: x < y) config.system.nixos.tags)
    ++ [config.system.nixos.version]
  );
}
