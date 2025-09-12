{
  lib,
  config,
  pkgs,
  ...
}: {

  home.file.".config/labwc/environment".text = ''
    # Desktop and Wayland
    XDG_CURRENT_DESKTOP=labwc
    XDG_SESSION_TYPE=wayland
    GDK_BACKEND=wayland,x11
    QT_QPA_PLATFORM=wayland;xcb
    QT_WAYLAND_DISABLE_WINDOWDECORATION=1
    SDL_VIDEODRIVER=wayland
    CLUTTER_BACKEND=wayland
    MOZ_ENABLE_WAYLAND=1
    MOZ_GTK_TITLEBAR_DECORATION=system
    GDK_SCALE=1
    WLR_DRM_NO_ATOMIC=1
  '';
}
