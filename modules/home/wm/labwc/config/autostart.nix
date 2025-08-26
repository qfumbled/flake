{
  pkgs,
  config,
  ...
}: {
  home.file.".config/labwc/autostart".text = ''
  swaybg -i ~/home/shared/wallpapers/test.png -m fill >/dev/null 2>&1 &
   #swaybg -i ~/home/shared/wallpapers/far.jpg -m fill >/dev/null 2>&1 &
    mako >/dev/null 2>&1 &2
    waybar >/dev/null 2>&1 &
    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1
  '';
}
