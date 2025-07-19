{pkgs, ...}: {
  programs.git = {
    enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "zeditor";
      credential.helper = "store";
      github.user = "q.fumbled";
      push.autoSetupRemote = true;
    };
    userEmail = "q.fumbled@proton.me";
    userName = "qfumbled";
  };
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
  services.ssh-agent = {
    enable = pkgs.stdenv.isLinux;
  };
}
