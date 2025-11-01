{ pkgs, ... }:

{
  home.packages = with pkgs; [
    slack
    notion-app-enhanced

    modrinth-app
  ];
}
