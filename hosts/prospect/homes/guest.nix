{
  flakeRoot,
  pkgs,
  pkgs-unstable,
  ...
}:

{
  imports = [
    (flakeRoot + /homes/shared/common/bat.nix)
    (flakeRoot + /homes/shared/common/eza.nix)
    (flakeRoot + /homes/shared/common/xh.nix)

    (flakeRoot + /homes/shared/desktop/firefox.nix)

    (flakeRoot + /homes/shared/desktop/prismlauncher.nix)
  ];
}
