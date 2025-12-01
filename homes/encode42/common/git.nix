{
  programs.git = {
    enable = true;

    signing = {
      signByDefault = true;

      format = "openpgp";
      key = "2DB55D48E857C8C7C6DF239580B9576520BBBF2D";
    };

    settings = {
      user = {
        name = "encode42";
        email = "me@encode42.dev";
      };

      init.defaultBranch = "main";
    };
  };
}
