{ pkgs, ... }:

{
  qt = {
    enable = true;
    platformTheme = "kde6";
  };

  environment.systemPackages = with pkgs; [
  ];

  environment.variables = {
# man
  };
}
