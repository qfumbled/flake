programs.spicetify =
let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  enable = true;

  enabledExtensions = with spicePkgs.extensions; [
    adblock
    hidePodcasts
    shuffle
  ];

  enabledCustomApps = with spicePkgs.apps; [
    newReleases
    ncsVisualizer
  ];

  enabledSnippets = with spicePkgs.snippets; [
    pointer
  ];
}
