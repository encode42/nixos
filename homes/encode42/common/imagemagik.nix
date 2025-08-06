{ pkgs, ... }:

{
  home.packages = with pkgs; [
    (imagemagick.override {
      libpngSupport = true;
      libjpegSupport = true;
      libwebpSupport = true;
      librsvgSupport = true;
    })
  ];
}
