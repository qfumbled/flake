{pkgs, ...}: {
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

      # Core options
      core = {
        editor = "zeditor";
        pager = "less -F -X -R"; # safe and common pager flags
        rerere = true; # enable rerere to reuse conflict resolutions
        fsckObjects = true; # verify objects before checkout/merge (extra safety)
        safecrlf = "warn"; # warn if line endings could be corrupted
      };

      # Credentials
      credential.helper = "store"; # stores credentials unencrypted

      github.user = "qfumbled";

      push.autoSetupRemote = true;
      pull.rebase = false;

      # Safer pushing advice
      advice.pushNonFFCurrent = true;
      push.default = "simple";
    };
  };

  ignores = [
    "*.log"
    ".envrc"
    "shell.nix"
  ];

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  services.ssh-agent = {
    enable = pkgs.stdenv.isLinux;
  };
}
