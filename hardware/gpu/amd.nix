{ nixos-hardware, pkgs, ... }:

{
  imports = [
    nixos-hardware.nixosModules.common-gpu-amd
  ];

  hardware.graphics.extraPackages = with pkgs; [
    rocmPackages.clr.icd
  ];

  programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
    obs-vaapi
  ];
}
