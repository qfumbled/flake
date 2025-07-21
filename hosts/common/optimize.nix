{
  config,
  pkgs,
  ...
}: {
  nix.settings.auto-optimise-store = true;
}
