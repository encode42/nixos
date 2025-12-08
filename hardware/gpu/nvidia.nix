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
    open = true;

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

  services.immich.settings.ffmpeg.accel = "nvenc";

  programs.gamemode.settings.gpu.nv_powermizer_mode = 1;
}
