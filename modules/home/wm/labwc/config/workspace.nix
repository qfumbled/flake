{
  pkgs,
  config,
  ...
}:
{
  home.file.".config/labwc/workspace.xml".text = ''
    <?xml version="1.0"?>
    <workspaces>
      <workspace name="1"/>
      <workspace name="2"/>
      <workspace name="3"/>
    </workspaces>
  '';
}
