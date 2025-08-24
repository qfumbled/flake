{ lib, ... }:
{
  imports = lib.meadow.readSubdirs ./.;
  options.meadow.default.shell = lib.mkOption {
    type = lib.types.listOf (
      lib.types.enum [
        "zsh"
        "fish"
        "mksh"
        "nushell"
      ]
    );
    default = [ "fish" ];
  };
}
