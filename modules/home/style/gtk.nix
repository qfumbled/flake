{ pkgs, lib, ... }:

{
  gtk = {
    enable = true;
    iconTheme = {
      name = lib.mkForce "MoreWaita";
      package = pkgs.morewaita-icon-theme;
    };
  };

  qt = {
    enable = true;
  };
}
