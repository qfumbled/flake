{ pkgs, lib, config, ... }:

let
# define workspaces typ ur num
  workspaceCount = 3;

  # Automatically generate workspace names as strings: ["1" "2" "3"]
  workspaceNames = map toString (lib.range 1 workspaceCount);

  workspaceDefs = lib.concatMapStrings (ws: ''
    <workspace name="${ws}"/>
  '') workspaceNames;

  jumpKeybinds = lib.concatMapStrings (ws: ''
    <keybind key="W+${ws}">
      <command>workspace ${ws}</command>
    </keybind>
  '') workspaceNames;

  moveKeybinds = lib.concatMapStrings (ws: ''
    <!--
    <keybind key="WS+${ws}">
      <command>move-to-workspace ${ws}</command>
    </keybind>
    -->
  '') workspaceNames;

in {
  home.file.".config/labwc/workspace.xml".text = ''
    <?xml version="1.0"?>
    <workspaces>
      ${workspaceDefs}

      <!-- Jump to workspace with Super+Number -->
      ${jumpKeybinds}

      <!-- Move-to-workspace bindings (disabled) -->
      ${moveKeybinds}
    </workspaces>
  '';
}
