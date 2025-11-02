{
  programs.git = {
    enable = true;

    userName = "encode42";
    userEmail = "me@encode42.dev";

    signing = {
      signByDefault = true;

      format = "openpgp";
      key = "2DB55D48E857C8C7C6DF239580B9576520BBBF2D";
    };

    extraConfig = {
      init.defaultBranch = "main";
    };
  };
}
