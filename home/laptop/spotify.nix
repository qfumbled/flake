{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = let
    spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};

    test = {
      scheme = "test";
      author = "kevin";
      base00 = "f5f3ef";
      base01 = "e6e5e4";
      base02 = "cccbca";
      base03 = "b3b2b1";
      base04 = "999898";
      base05 = "5c5c5c";
      base06 = "5c5c5c";
      base07 = "5c5c5c";
      base08 = "b66467";
      base09 = "b88757";
      base0A = "b88757";
      base0B = "76b05c";
      base0C = "7d9ea7";
      base0D = "66858f";
      base0E = "9661cc";
      base0F = "aaa9a9";
    };

    far = {
      scheme = "far";
      author = "Kevin";
      base00 = "0f1314";
      base01 = "151a1c";
      base02 = "21282b";
      base03 = "364044";
      base04 = "a8a8a8";
      base05 = "c2c4c2";
      base06 = "c2c4c2";
      base07 = "d4d9d4";
      base08 = "b24957";
      base09 = "d08666";
      base0A = "95b971";
      base0B = "6a9440";
      base0C = "75ad99";
      base0D = "598278";
      base0E = "e7ae77";
      base0F = "717171";
    };
  in {
    enable = true;
    spotifyPackage = pkgs.spotify;
    spicetifyPackage = pkgs.spicetify-cli;

    enabledExtensions = with spicePkgs.extensions; [
      adblock
      shuffle
    ];

    theme = spicePkgs.themes.comfy;

    colorScheme = test.scheme; # You can switch between 'test' or 'far'

    customColorScheme = test; # For 'test' color scheme, switch to 'far' if needed
  };
}
