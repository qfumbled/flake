{config, ...}: {
  programs.gpg = {
    enable = true;
    homedir = "${config.xdg.dataHome}/gnupg";
    settings = {
      use-agent = true;
      default-key = "A5208AEC2D69F0F0EB43AC51802C005FEE2D5C85";
    };
  };
}
