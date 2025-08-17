{ config, lib, pkgs, ... }: {
  options = {
    astridConfig.windowManagers.river = {
      enable = lib.mkEnableOption "river";

      modKey = lib.mkOption {
        type = lib.types.str;
        default = "Super";
        description = "Primary mod key used for river keybinds";
        example = "Super";
      };
    };
  };

  config = lib.mkIf config.astridConfig.windowManagers.river.enable {
    wayland.windowManager.river = {
      enable = true;
      xwayland.enable = true;

      extraSessionVariables = {
        WLR_NO_HARDWARE_CURSORS = "1";
      };

      settings = {
        map.normal."${config.astridConfig.windowManagers.river.modKey} Return" = "spawn foot";
        map.normal."${config.astridConfig.windowManagers.river.modKey} q" = "close";
        map.normal."${config.astridConfig.windowManagers.river.modKey} d" = "spawn 'rofi -show drun";
        map.normal."${config.astridConfig.windowManagers.river.modKey}+Shift q" = "exit";
      };

      extraConfig = ''
        # Map tags
        for i in {1..9}; do
          riverctl map normal ${config.astridConfig.windowManagers.river.modKey} $i set-focused-tags $((1 << (i - 1)))
          riverctl map normal ${config.astridConfig.windowManagers.river.modKey}+Shift $i set-view-tags $((1 << (i - 1)))
          riverctl map normal ${config.astridConfig.windowManagers.river.modKey}+Control $i toggle-focused-tags $((1 << (i - 1)))
          riverctl map normal ${config.astridConfig.windowManagers.river.modKey}+Control+Shift $i toggle-view-tags $((1 << (i - 1)))
        done

        for pad in $(riverctl list-inputs | grep -i touchpad )
do
  riverctl input $pad events enabled
  riverctl input $pad tap enabled
done
riverctl map-pointer normal Super BTN_RIGHT move-view
riverctl spawn waybar
#riverctl spawn mako

riverctl input pointer-961030-Pine64_Pinebook_Pro_Touchpad tap enabled
riverctl input pointer-9610-30-Pine64_Pinebook_Pro_Touchpad natural-scroll enabled
riverctl map-pointer normal Super BTN_RIGHT resize-view
riverctl map-pointer normal Super BTN_LEFT move-view


for mode in normal locked; do
    riverctl map $mode None XF86MonBrightnessUp   spawn 'brightnessctl set +5%'
    riverctl map $mode None XF86MonBrightnessDown spawn 'brightnessctl set 5%-'
    riverctl map $mode None XF86AudioRaiseVolume spawn 'amixer -D pulse sset Master 5%+'
    riverctl map $mode None XF86AudioLowerVolume spawn 'amixer -D pulse sset Master 5%-'
    riverctl map $mode None XF86AudioMute        spawn 'amixer -D pulse set Master 1+ toggle'
    riverctl map-switch $mode lid close spawn 'wlr-randr --output eDP-1 --off'
    riverctl map-switch $mode lid open spawn 'wlr-randr --output eDP-1 --on'
done
riverctl map normal None Print spawn 'grim -g "$(slurp)" - | wl-copy'
 riverctl hide-cursor when-typing enabled
 riverctl focus-follows-cursor always
 riverctl set-cursor-warp on-focus-change
 riverctl map normal Super F toggle-fullscreen
      '';
    };
  };
}
