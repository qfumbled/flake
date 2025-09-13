_: {
  # nh default flake
  environment.variables.NH_FLAKE = "/home/wug";

  programs.nh = {
    enable = true;
    # weekly cleanup
    clean = {
      enable = true;
      extraArgs = "--keep-since 1d";
    };
  };
}
