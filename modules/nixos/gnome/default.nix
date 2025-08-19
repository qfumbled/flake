{ config, pkgs, ... }:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
    gnomeExtensions.dash-to-dock
  ];

  environment.gnome.excludePackages =
    (with pkgs; [
      gnome-text-editor
      gnome-console
      gnome-photos
      gnome-tour
      gnome-connections
      snapshot
      gedit
      cheese # webcam tool
      epiphany # web browser
      geary # email reader
      evince # document viewer
      totem # video player
      yelp # Help viewer
      gnome-font-viewer
    ])
    ++ [
      pkgs.gnome-music
      pkgs.gnome-characters
      pkgs.tali
      pkgs.iagno
      pkgs.hitori
      pkgs.atomix
      pkgs.gnome-contacts
      pkgs.gnome-initial-setup
      pkgs.gnome-shell-extensions
      pkgs.gnome-maps
    ];
}
