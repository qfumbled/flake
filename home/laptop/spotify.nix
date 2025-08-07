{
  inputs,
  pkgs,
  config,
  ...
}: {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

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

    # Define theme as an attribute set for Spicetify
    theme = {
      name = "custom";
      custom = {
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

        # Specific UI element customizations
        text = "base05";
        subtext = "base05";
        main = "base00";
        main-elevated = "base02";
        sidebar = "base01";
        highlight = "base01";
        highlight-elevated = "base02";
        player = "base01";
        card = "base02";
        shadow = "base00";
        selected-row = "base05";
        button = "base05";
        button-active = "base05";
        button-disabled = "base04";
        tab-active = "base02";
        notification = "base02";
        notification-error = "base08";
        equalizer = "base0B";
        misc = "base02";
      };
    };
  };
}
