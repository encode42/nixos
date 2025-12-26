{ pkgs, ... }:

{
  # TODO: package Vita3k and Gearsystem

  home.packages = with pkgs; [
    r2modman
    olympus
  ];
}
