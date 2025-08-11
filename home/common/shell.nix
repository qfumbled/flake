{ pkgs, ... }: {
  # Enable Nushell
  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;  # Disables Nushell's startup banner
      aliases = {
        ls = "eza";  # ls -> eza
        zed = "zeditor";  # zed -> zeditor
        ll = "eza -h --git --icons --color=auto --group-directories-first -s extension";  # Enhanced ls
        cat = "bat --number --color=always --paging=never --tabs=2 --wrap=never";  # cat -> bat
        cd = "zoxide";  # cd -> zoxide for fast directory navigation
        z = "zoxide";  # Alias z for zoxide
      };
    };
  };

  # Enable Starship prompt with Nushell integration
  programs.starship = {
    enable = true;
    enableNushellIntegration = true;
    settings = {
      add_newline = false;
    };
  };

  # Enable Direnv with Nushell integration
  programs.direnv = {
    enable = true;
    enableNushellIntegration = true;
  };

  # Enable Carapace with Nushell integration
  programs.carapace = {
    enable = true;
    enableNushellIntegration = true;
  };

    programs.zoxide = {
      enable = true;
      settings = {
        init = ''
          if [[ "$($SHELL)" == *"nu"* ]]; then
            export _ZO_CMD=zoxide
            eval "$(zoxide init nushell)"
          fi
        '';
      };
    };
  };
}
