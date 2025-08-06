{ pkgs, ... }:

{
  home.packages = [
    (pkgs.prismlauncher.override {
      additionalPrograms = with pkgs; [
        ffmpeg
      ];

      jdks = with pkgs; [
        temurin-jre-bin-8
        temurin-jre-bin-17
        temurin-bin
      ];
    })
  ];
}
