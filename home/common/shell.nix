{ pkgs, ... }: {
  # Enable Nushell
  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
    };
  };

  # Enable Nushell plugins (skim, query, gstat, polars)
  plugins = with pkgs.nushellPlugins; [
    query
    gstat
    polars
  ];

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

  # Enable zoxide for fast directory navigation
  programs.zoxide = {
    enable = true;
    settings = {
      init = ''
        if [ $SHELL == "/usr/bin/nu" ]; then
          export _ZO_CMD=zoxide
          eval "$(zoxide init nushell)"
        fi
      '';
    };
  };

  # Set up aliases
  environment.shellAliases = {
    ls = "eza";  # ls -> eza
    zed = "zeditor";  # zed -> zeditor
    ll = "eza -h --git --icons --color=auto --group-directories-first -s extension";  # Enhanced ls
    cd = "zoxide";  # cd -> zoxide for fast directory navigation
    cat = "bat --number --color=always --paging=never --tabs=2 --wrap=never";  # cat -> bat
    z = "zoxide";  # Alias z for zoxide
  };

  # Ensure zed is available if needed
  environment.systemPackages = with pkgs; [
    zed
  ];
}
