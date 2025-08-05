{ ... }: {
  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
      aliases = {
        # nh = "nh";  # doesn't work
      };
    };
    extraConfig = ''
      def desktop-switch [] { sudo nixos-rebuild switch --flake .#desktop }
      def laptop-switch [] { sudo nixos-rebuild switch --flake .#laptop }
      def deck-switch [] { sudo nixos-rebuild switch --flake .#deck }
    '';
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
