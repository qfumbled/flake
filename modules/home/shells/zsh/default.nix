{ config, lib, ... }:

{
  imports = [ ./run-as-service.nix ];

  config = {
    # SOPS-managed secret
    sops.secrets."env.zsh" = {
      path = "${config.xdg.configHome}/zsh/env.zsh";
    };

    programs.zsh = {
      enable = true;
      dotDir = "${config.xdg.configHome}/zsh"; 
      envExtra = ''
        export PATH=$HOME/.local/bin:$HOME/.local/share/nvim/mason/bin:$PATH
      '';
      initExtra = ''
        source ${config.xdg.configHome}/zsh/env.zsh
        source ${config.xdg.configHome}/zsh/aliases.zsh
        source ${config.xdg.configHome}/zsh/options.zsh
        source ${config.xdg.configHome}/zsh/plugins.zsh
        source ${config.xdg.configHome}/zsh/utility.zsh
        source ${config.xdg.configHome}/zsh/keybinds.zsh
      '';
    };

    programs.atuin = {
      enable = true;
      enableZshIntegration = true;
      enableFishIntegration = true;
      settings = {
        style = "compact";
        show_tabs = false;
        show_help = false;
        enter_accept = true;
      };
    };

    home.file.kubie = {
      target = ".kube/kubie.yaml";
      text = ''
        prompt:
          disable: true
      '';
    };
  };
}
