{ pkgs, ... }:

{
  home.shellAliases = {
    ls = "eza -la";
    tree = "eza -T";
  };

  home.packages = with pkgs; [
    eza
  ];
}
