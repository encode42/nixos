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
  ];

  home.packages = with pkgs; [
    cyanrip

    # Unstable to keep up-to-date with authentication servers
    pkgs-unstable.makemkv
  ];
}
