{ pkgs, pkgs-winboat, ... }:

{
  environment.systemPackages = with pkgs; [
    pkgs.freerdp3
    pkgs.docker-compose
    pkgs-winboat.winboat
  ];

  virtualisation.docker.enable = true;
}
