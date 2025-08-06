{
  programs.git = {
    enable = true;

    userName = "encode42";
    userEmail = "me@encode42.dev";

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
