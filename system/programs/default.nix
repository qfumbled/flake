{ lib, ... }:

{
  programs = {
    nix-ld.enable = true;
    zsh.enable = true;
    fish.enable = true;
    dconf.enable = true;
    wshowkeys.enable = true;
  };

  imports = lib.meadow.readSubfiles ./. [ "default.nix" ];
}
