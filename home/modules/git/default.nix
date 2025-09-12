{
  config,
  lib,
  pkgs,
  ...
}: {
  programs = {
    git = {
      enable = true;
      userEmail = "rs.wug@proton.me";
      userName = "wug";

      ignores = [
        "*.log"
        ".envrc"
        "shell.nix"
      ];

      extraConfig = {
        commit.gpgsign = false;
        core = {
          editor = "nvim";
          excludesfile = "~/.config/git/ignore";
          pager = "${lib.getExe pkgs.diff-so-fancy}";
        };
        pager = {
          diff = "${lib.getExe pkgs.diff-so-fancy}";
          log = "delta";
          reflog = "delta";
          show = "delta";
        };

        credential = {
          helper = "store";
        };

        push = {
          autoSetupRemote = true;
        };

        rerere.enable = true;

        color = {
          ui = true;
          pager = true;
          diff = "auto";
          branch = {
            current = "green bold";
            local = "yellow dim";
            remove = "blue";
          };

          showBranch = "auto";
          interactive = "auto";
          grep = "auto";
          status = {
            added = "green";
            changed = "yellow";
            untracked = "red dim";
            branch = "cyan";
            header = "dim white";
            nobranch = "white";
          };
        };
      };

      aliases = {
        st = "status ";
        ci = "commit ";
        br = "branch ";
        co = "checkout ";
        df = "diff ";
        dc = "diff - -cached ";
        lg = "log - p ";
        pr = "pull - -rebase ";
        p = "push ";
        ppr = "push - -set-upstream origin ";
        lol = "log - -graph - -decorate - -pretty=oneline --abbrev-commit";
        lola = "log --graph --decorate --pretty=oneline --abbrev-commit --all";
        latest = "for-each-ref --sort=-taggerdate --format='%(refname:short)' --count=1";
        undo = "git reset --soft HEAD^";
        brd = "branch -D";
      };
    };

    zsh.initContent = ''
      # why?
    '';

    fish.interactiveShellInit = ''
    # why?
    '';
  };
}

