{...}: {
  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
    };
  };

  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      add_newline = false;
    };
  };

  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
  };

  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };
}
