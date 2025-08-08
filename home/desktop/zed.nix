{pkgs, ...}: {
  home.packages = with pkgs; [
    nil
    alejandra
  ];

  programs.zed-editor = {
    enable = true;
    extensions = ["nix" "rust" "make" "html" "toml" "yaml" "git-firefly"];

    userSettings = {
      theme = {
        mode = "system";
        light = "One Light";
        dark = "One Black";
      };

      lsp = {
        nil = {
          binary = {
            path = "${pkgs.nil}/bin/nil";
          };
          initialization_options = {
            formatting = {
              command = ["alejandra" "--quiet" "--"];
            };
          };
        };
      };

      languages = {
        Nix = {
          language_servers = ["nil" "!nixd"];
        };
      };
    };
  };
}
