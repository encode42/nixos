{
  flakeRoot,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  imports = [
    (flakeRoot + /homes/encode42/common)

    (flakeRoot + /homes/encode42/common/github.nix)
    (flakeRoot + /homes/encode42/common/direnv.nix)

    (flakeRoot + /homes/encode42/common/imagemagik.nix)

    (flakeRoot + /homes/encode42/desktop/cursor.nix)
    (flakeRoot + /homes/encode42/desktop/fonts.nix)

    (flakeRoot + /homes/encode42/desktop/environments/gnome.nix)

    (flakeRoot + /homes/encode42/desktop/jetbrains/intellij.nix)
    (flakeRoot + /homes/encode42/desktop/jetbrains/rustrover.nix)
    (flakeRoot + /homes/encode42/desktop/jetbrains/webstorm.nix)

    (flakeRoot + /homes/encode42/desktop/discord.nix)
    (flakeRoot + /homes/encode42/desktop/firefox.nix)

    (flakeRoot + /homes/shared/desktop/prismlauncher.nix)
  ];

  home.packages = with pkgs; [
    ffmpeg
    rsgain
    audacity
    pkgs-unstable.puddletag

    blockbench

    clonehero
    openrct2
    r2modman
    pkgs-unstable.olympus

    slack
  ];
}
