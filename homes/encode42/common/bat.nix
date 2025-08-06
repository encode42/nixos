{ pkgs, ... }:

{
  programs.bat = {
    enable = true;

    config = {
      paging = "never";

      theme = "base16";

      style = [
        "numbers"
      ];
    };
  };

  home.shellAliases = {
    cat = "bat";
  };

  home.packages = with pkgs; [
    bat
  ];
}
