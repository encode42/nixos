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

    (flakeRoot + /homes/encode42/common/bat.nix)
    (flakeRoot + /homes/encode42/common/eza.nix)
    (flakeRoot + /homes/encode42/common/xh.nix)

    (flakeRoot + /homes/encode42/desktop/cursor.nix)
    (flakeRoot + /homes/encode42/desktop/fonts.nix)

    (flakeRoot + /homes/encode42/desktop/environments/gnome.nix)

    (flakeRoot + /homes/encode42/desktop/jetbrains/intellij.nix)

    (flakeRoot + /homes/encode42/desktop/discord.nix)
    (flakeRoot + /homes/encode42/desktop/firefox.nix)

    (flakeRoot + /homes/encode42/desktop/prismlauncher.nix)
  ];

  home.packages = with pkgs; [
    dolphin-emu
    r2modman

    slack
  ];
}
