{
  imports = [
    ../../shared/common/bat.nix
  ];

  programs.bat = {
    config = {
      color = "auto";

      theme = "base16";

      style = [
        "numbers"
      ];
    };
  };
}