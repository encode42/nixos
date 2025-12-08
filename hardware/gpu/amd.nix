{ nixos-hardware, pkgs, ... }:

{
  imports = [
    nixos-hardware.nixosModules.common-gpu-amd
  ];

  hardware = {
    graphics.extraPackages = with pkgs; [
      rocmPackages.clr.icd
    ];

    amdgpu.opencl.enable = true;
  };

  systemd.tmpfiles.rules =
    let
      rocmEnv = pkgs.symlinkJoin {
        name = "rocm-combined";
        paths = with pkgs.rocmPackages; [
          rocblas
          hipblas
          clr
        ];
      };
    in
    [
      "L+    /opt/rocm   -    -    -     -    ${rocmEnv}"
    ];

  programs.obs-studio.plugins = with pkgs.obs-studio-plugins; [
    obs-vaapi
  ];

  services.immich.settings.ffmpeg.accel = "vaapi";

  programs.gamemode.settings.gpu.amd_performance_level = "high";
}
