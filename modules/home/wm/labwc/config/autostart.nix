{
  pkgs,
  config,
  ...
}: {
  home.file.".config/labwc/autostart".text = ''
   # light mode  swaybg -i ~/home/shared/wallpapers/accordion.png -m fill >/dev/null 2>&1 &
    swaybg -i ~/home/shared/wallpapers/leaving-breeze.jpg -m fill >/dev/null 2>&1 & # dark mode
    mako >/dev/null 2>&1 &2
    waybar >/dev/null 2>&1 &
    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
  '';
}
