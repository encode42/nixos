{ pkgs, pkgs-unstable, ... }:

{
  environment.systemPackages = with pkgs; [
    freerdp
    docker-compose

    # Unstable for winboat 0.9.0, roll back to stable once backported
    pkgs-unstable.winboat
  ];

  virtualisation.docker.enable = true;
}
