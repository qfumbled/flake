{
  pkgs,
  config,
  ...
}:

let
  fzfOpts = with config.lib.stylix.colors; {
    export = {
      FZF_DEFAULT_OPTS = ''
        $FZF_DEFAULT_OPTS \
        --color=fg:#${base04},bg:#${base00},hl:#${base0D} \
        --color=fg+:#${base06},bg+:#${base01},hl+:#${base0D} \
        --color=info:#${base0D},prompt:#${base0D},pointer:#${base0C} \
        --color=marker:#${base0C},spinner:#${base0C},header:#${base0D}
      '';
    };
  };
in
{
  home.packages = with pkgs; [
    mksh
    fd
    fzf
    eza
  ];

  programs.fzf.enable = true;

  programs.eza = {
    enable = true;
    icons = null;
  };

  home.file.".mkshrc".text = ''
    # vim: ft=sh

    HISTFILE=$HOME/.mksh_history
    HISTSIZE=5000
    HISTCONTROL=ignoreboth

    ${fzfOpts}

    # Aliases
    aliases = {
      l   = "eza -lh";
      ls  = "eza -1";
      ll  = "eza -lha --sort=name --group-directories-first";
      ld  = "eza -lhD";
      yz  = "yazi";
      dev = "nix develop -c tmux";
      vg  = "valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrind-out.txt";
    };

    # Custom cd function
    cd() {
      local target="$1"
      local parent
      local top

      if [ "$target" = ":/" ]; then
          if top=$(git rev-parse --show-cdup 2>/dev/null); then
              [ -n "$top" ] && builtin cd "$top"
          fi
      elif [ -f "$target" ] && [ -e "$target" ]; then
          parent=$(dirname "$target")
          if [ "$parent" != "." ] && [ -d "$parent" ]; then
              builtin cd "$parent"
          fi
      elif [ -d "$target" ]; then
          builtin cd "$target"
      else
          builtin cd
      fi

      if git rev-parse --git-dir >/dev/null 2>&1; then
          local repo
          repo=$(basename "$(git rev-parse --show-toplevel)")
          if [ -z "$LAST_REPO" ] || [ "$LAST_REPO" != "$repo" ]; then
              onefetch
              export LAST_REPO="$repo"
          fi
      fi
    }

    # Fuzzy directory changer
    cdd() {
      local dir
      dir=$(fd -H -t d -a | fzf)
      [ -n "$dir" ] && cd "$dir"
    }

    # Go up n directories (default 1)
    ..() {
      local n=1
      local i
      [ -n "$1" ] && n="$1"
      for i in $(seq 1 "$n"); do
        cd ..
      done
    }

    set -o vi
    cd "$PWD"
  '';
}
