{ pkgs, ... }:

{
  programs.steam = {
    enable = true;

    extest.enable = true;

    extraCompatPackages = with pkgs; [
      proton-ge-bin
    ];

    remotePlay.openFirewall = true;
  };
}
