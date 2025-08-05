{pkgs, ...}: {
  imports = [
    ../common
    ./plasma.nix
    ./vesktop.nix
  ];

  home = {
    packages = with pkgs; [
      protonup
      heroic
      brave
    ];

    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/cmopatibilitytools.d";
    };
  };
}
