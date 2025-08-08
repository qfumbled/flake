{ pkgs, ... }: {
  programs.git = {
    enable = true;
    userEmail = "q.fumbled@proton.me";
    userName = "qfumbled";

    extraConfig = ''
      color.ui = true
      core.editor = zeditor
      credential.helper = store
      github.user = qfumbled
      push.autoSetupRemote = true
      pull.rebase = false
    '';
  };

  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };

  services.ssh-agent = {
    enable = pkgs.stdenv.isLinux;
  };
}
