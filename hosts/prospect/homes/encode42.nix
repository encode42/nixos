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

    (flakeRoot + /homes/encode42/desktop/environments/gnome.nix)

    (flakeRoot + /homes/encode42/desktop/firefox.nix)

    (flakeRoot + /homes/shared/desktop/prismlauncher.nix)
  ];
}
