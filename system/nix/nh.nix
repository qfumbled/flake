_: {
  # nh default flake
  environment.variables.NH_FLAKE = "/home/monaco/flake";

  programs.nh = {
    enable = true;
    # weekly cleanup
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d";
    };
  };
}
