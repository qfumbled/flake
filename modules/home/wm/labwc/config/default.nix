{ lib, ... }:

{
  imports = lib.meadow.readSubfiles ./. [ "default.nix" "workspace.nix" ];
}
