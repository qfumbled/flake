{...}: {
  programs = {
    git = {
      enable = true;
      userName = "wug";
      userEmail = "rs.wug@proton.me";
      extraConfig = {
        init = {
          defaulBranch = "main";
        };
      };
    };

    lazygit = {
      enable = true;
    };
  };
}
