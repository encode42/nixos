{ pkgs, ... }:

{
  home.shellAliases = {
    curl = "xh";
  };

  home.packages = with pkgs; [
    xh
  ];
}
