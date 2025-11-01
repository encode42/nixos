{ pkgs, pkgs-winboat, ... }:

{
  environment.systemPackages = with pkgs; [
    freerdp3
    docker-compose
    pkgs-winboat.winboat
  ];

  virtualisation.docker.enable = true;
}
