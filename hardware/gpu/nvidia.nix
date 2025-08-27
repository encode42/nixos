{
  lib,
  nixos-hardware,
  pkgs,
  isLaptop,
  ...
}:

{
  imports = [
    nixos-hardware.nixosModules.common-gpu-nvidia
  ];

  services.xserver.videoDrivers = [
    "nvidia"
  ]
  ++ lib.optional isLaptop "modesetting";

  hardware.nvidia = {
    open = false; # Currently unable to build

    modesetting.enable = isLaptop;

    prime = {
      offload.enable = isLaptop;
    };
  };

  programs.obs-studio.package = (
    pkgs.obs-studio.override {
      cudaSupport = true;
    }
  );
}
