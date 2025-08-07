{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [inputs.spicetify-nx.homeManagerModules.default];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
  in {
    enable = true;
    spotifyPackage = pkgs.spotify;
    spicetifyPackage = pkgs.spicetify-cli;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      shuffle
    ];

    theme = spicePkgs.themes.comfy;
  };
}
