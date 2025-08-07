{pkgs, ...}: {
  imports = [
    ../common
    ./plasma.nix
    ./vesktop.nix
    ./spotify.nix
  ];

  home = {
    packages = with pkgs; [
      protonup
      heroic
      bibata-cursors
    ];

    sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/cmopatibilitytools.d";
    };
  };
}
