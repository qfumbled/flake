{ pkgs, ... }:

{
  programs.git = {
    enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "zeditor";
      credential.helper = "store";
      github.user = "qfumbled";
      push.autoSetupRemote = true;
    };
    userEmail = "q.fumbled@proton.me";
    userName = "qfumbled";
  };
}
