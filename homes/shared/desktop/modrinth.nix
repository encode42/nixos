{ pkgs-unstable, ... }:

{
  home.packages = with pkgs-unstable; [
    modrinth-app
  ];
}
