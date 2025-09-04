{ lib, pkgs, ... }:

{
  programs.bat = {
    enable = true;

    config = {
      paging = lib.mkDefault "never";

      color = lib.mkDefault "never";

      style = lib.mkDefault [
        "plain"
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
