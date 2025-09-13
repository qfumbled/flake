{
  lib,
  ...
}:

{
  options = {
    wallpaper = lib.mkOption {
      default = ../wallpapers/aesthetic.png;
      type = lib.types.path;
    };
  };

  config = {
    wallpaper = ../wallpapers/aesthetic.png;
  };
}
