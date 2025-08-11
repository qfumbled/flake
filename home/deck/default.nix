{pkgs, ...}: {
  imports = [
    ../common
    ./plasma.nix
    ./spotify.nix
  ];

  home = {
    packages = with pkgs; [
      protonup
    ];

    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/cmopatibilitytools.d";
    };
  };
}
