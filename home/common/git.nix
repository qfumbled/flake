{
  pkgs,
  config,
  ...
}: {
  programs.git = {
    enable = true;
    userEmail = "q.fumbled@proton.me";
    userName = "qfumbled";

    extraConfig = {
      color.ui = true;
      color.showBranch = "auto";
      color.interactive = "auto";
      color.grep = "auto";
      color.status = {
        added = "green";
        changed = "yellow";
        untracked = "red dim";
        branch = "cyan";
        header = "dim white";
        nobranch = "white";
      };

      core = {
        editor = "zeditor";
        pager = "less -F -X -R";
        rerere = true;
        fsckObjects = true;
        safecrlf = "warn";
        excludesFile = "${config.home.homeDirectory}/.config/git/ignore";
      };

      credential.helper = "store";

      github.user = "qfumbled";

      push.autoSetupRemote = true;
      pull.rebase = false;

      advice.pushNonFFCurrent = true;
      push.default = "simple";
    };
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  services.ssh-agent = {
    enable = pkgs.stdenv.isLinux;
  };
}
