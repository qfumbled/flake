{ lib, ... }:

{
  qt = {
    enable = true;
    platformTheme = lib.mkForce "gtk2";
    style = lib.mkForce "gtk2";
  };
}
