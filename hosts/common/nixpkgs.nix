{...}: {
  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "olm-3.2.16"
    ];

    chromium.enableWideVine = true;
  };
}
