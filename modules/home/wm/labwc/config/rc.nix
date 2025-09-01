{
  config,
  pkgs,
  lib,
  ...
}:

let
  screenshot = import ../scripts/screenshot.nix pkgs;
  lock = import ../scripts/waylock.nix { inherit pkgs config; };
  terminal = config.home.sessionVariables.TERMINAL;
in
{
  home.file.".config/labwc/rc.xml".text = ''
    <?xml version="1.0"?>
    <labwc_config>
      <theme>
        <name></name>
        <titlebar>
          <layout>:iconify,max,close</layout>
          <showTitle>yes</showTitle>
        </titlebar>
        <cornerRadius>0</cornerRadius>
        <font name="Rubik" size="9" />
      </theme>

      <keyboard>
        <default />

        <!-- Terminal -->
        <keybind key="W-Return">
          <action name="Execute" command="${terminal}" />
        </keybind>

        <!-- Apps -->
        <keybind key="C-W-f">
          <action name="Execute" command="firefox" />
        </keybind>
        <keybind key="W-Space">
          <action name="Execute" command="fuzzel" />
        </keybind>
        <keybind key="W-o">
          <action name="Execute" command="run-as-service wl-ocr" />
        </keybind>

        <!-- Controls -->
        <keybind key="W-f">
          <action name="ToggleMaximize" />
        </keybind>
        <keybind key="W-s">
          <action name="Iconify" />
        </keybind>
        <keybind key="W-q">
          <action name="Close" />
        </keybind>
        <keybind key="W-r">
          <action name="Reconfigure" />
        </keybind>
        <keybind key="C-W-l">
          <action name="Execute" command="${lock}/bin/lock" />
        </keybind>

        <!-- Screenshot -->
        <keybind key="W-A-s">
          <action name="Execute" command="${screenshot}/bin/screenshot f" />
        </keybind>
        <keybind key="W-S-s">
          <action name="Execute" command="${screenshot}/bin/screenshot s" />
        </keybind>

        <!-- Brightness + Volume -->
        <keybind key="XF86_AudioRaiseVolume">
          <action name="Execute" command="${pkgs.pamixer}/bin/pamixer -i 5" />
        </keybind>
        <keybind key="XF86_AudioLowerVolume">
          <action name="Execute" command="${pkgs.pamixer}/bin/pamixer -d 5" />
        </keybind>
        <keybind key="XF86_AudioMute">
          <action name="Execute" command="volumectl toggle-mute" />
        </keybind>
        <keybind key="XF86_AudioMicMute">
          <action name="Execute" command="${pkgs.pamixer}/bin/pamixer --default-source --toggle-mute" />
        </keybind>
        <keybind key="XF86_MonBrightnessUp">
          <action name="Execute" command="${pkgs.brillo}/bin/brillo -q -A 10" />
        </keybind>
        <keybind key="XF86_MonBrightnessDown">
          <action name="Execute" command="${pkgs.brillo}/bin/brillo -q -U 10" />
        </keybind>
      </keyboard>

      <mouse>
        <default />
        <context name="Root">
          <mousebind button="Left" action="Press" />
        </context>

        <context name="Frame">
          <mousebind button="W-Left" action="Press">
            <action name="Focus" />
            <action name="Raise" />
          </mousebind>
          <mousebind button="W-Left" action="Drag">
            <action name="Move" />
          </mousebind>
          <mousebind button="W-Right" action="Press">
            <action name="Focus" />
            <action name="Raise" />
          </mousebind>
          <mousebind button="W-Right" action="Drag">
            <action name="Resize" />
          </mousebind>
        </context>
      </mouse>
    </labwc_config>
  '';
}
