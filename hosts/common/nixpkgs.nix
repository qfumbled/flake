{...}: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "olm-3.2.16"
    ];
    programs.nix-ld.enable = true;
  };
}
