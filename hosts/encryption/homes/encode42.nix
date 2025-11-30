{
  flakeRoot,
  pkgs,
  pkgs-unstable,
  pkgs-personal,
  ...
}:

let
  mkConvertFunction = outputName: ''
    set downloadUrl $argv[1]
    set fileName download.tmp

    xh --download $downloadUrl --output $fileName

    set isOpaque (magick identify -format '%[opaque]' $fileName)
    set aspectRatio (magick $fileName -format "%[fx:w/h]" info:)

    set -l arguments;

    if test $isOpaque = "False"
      echo "Will replace transparency with solid color!"

      set -a arguments -background white -alpha remove -alpha off
    end

    if test $aspectRatio != "1"
      echo "Will adjust the image's cropping!"

      set -a arguments -gravity center -crop 1:1
    end

    magick $fileName $arguments -quality 100% -verbose ${outputName}

    rm -f $fileName
  '';
in
{
  imports = [
    (flakeRoot + /homes/encode42/common)

    (flakeRoot + /homes/encode42/common/github.nix)
    (flakeRoot + /homes/encode42/common/direnv.nix)

    (flakeRoot + /homes/encode42/common/imagemagik.nix)

    (flakeRoot + /homes/encode42/desktop/environments/gnome.nix)

    (flakeRoot + /homes/encode42/desktop/jetbrains/rider.nix)
    (flakeRoot + /homes/encode42/desktop/jetbrains/intellij.nix)
    (flakeRoot + /homes/encode42/desktop/discord.nix)
    (flakeRoot + /homes/encode42/desktop/firefox.nix)
    (flakeRoot + /homes/encode42/desktop/zed.nix)

    (flakeRoot + /homes/shared/desktop/prismlauncher.nix)
  ];

  programs.fish.functions = {
    download_cover = mkConvertFunction "cover.jpg";
    download_artist = mkConvertFunction "artist.jpg";
  };

  home.packages = with pkgs; [
    ffmpeg
    rsgain
    audacity
    pkgs-unstable.puddletag
    pkgs-unstable.eartag

    blockbench

    clonehero
    openrct2
    r2modman
    pkgs-unstable.olympus
    pkgs-personal.iso2god-rs
  ];
}
