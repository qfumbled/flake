{ pkgs, lib, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      name = lib.mkForce "Papirus-Dark";
      package = pkgs.papirus-icon-theme.override {color = "blue";};
    };
  };

  qt = {
    enable = true;
  };
}
