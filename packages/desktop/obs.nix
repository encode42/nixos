{ pkgs, ... }:

{
  programs.obs-studio = {
    enable = true;

    enableVirtualCamera = true;

    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-vkcapture

      obs-composite-blur
      input-overlay
    ];
  };

  programs.steam = {
    package = pkgs.steam.override {
      extraEnv = {
        OBS_VKCAPTURE = true;
      };
    };
  };
}
