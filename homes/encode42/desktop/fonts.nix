{ pkgs, ... }:

{
  home.packages = with pkgs; [
    inter
    jetbrains-mono

    twemoji-color-font
  ];
}
