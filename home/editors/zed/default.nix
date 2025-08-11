{ pkgs, ... }:

{
  # Home packages you need
  home.packages = with pkgs; [
    nodejs  # If you still want Node.js for non-web tasks, like scripting
    nil     # Nix language server for Nix development
    typescript-language-server  # If you're using TypeScript for non-web tasks
    typescript  # If you're working with TypeScript files
    zed-editor  # Text editor
    alejandra  # Formatter for Nix files
    rustc    # Rust compiler, if you work with Rust
    rust-analyzer  # Rust LSP (language server)
  ];

  # Language Servers Setup
  lsp = {
    nil = {
      binary = {
        path = "${pkgs.nil}/bin/nil";  # Path to nil language server for Nix
      };
      initialization_options = {
        formatting = {
          command = ["alejandra" "--quiet" "--"];  # Nix file formatter
        };
      };
    };

    # Adding language server support for Nix, and Rust if needed
    languages = {
      Nix = {
        language_servers = ["nil"];  # Nix language server
      };
      Rust = {
        language_servers = ["rust-analyzer"];  # Rust LSP
      };
    };
  };

  # Zed Editor Configuration
  programs.zed-editor = {
    enable = true;
    extensions = [
      "nix"    # Nix language support
      "rust"   # Rust language support
      "make"   # Makefile support (if needed)
      "toml"   # TOML file support (used for Rust, etc.)
      "yaml"   # YAML support
    ];
  };
}
