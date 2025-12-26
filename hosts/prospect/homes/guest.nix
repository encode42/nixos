{
  flakeRoot,
  ...
}:

{
  imports = [
    (flakeRoot + /homes/shared/common/bat.nix)
    (flakeRoot + /homes/shared/common/eza.nix)
    (flakeRoot + /homes/shared/common/xh.nix)

    (flakeRoot + /homes/shared/desktop/firefox.nix)

    (flakeRoot + /homes/shared/desktop/prismlauncher.nix)

    ./config/games.nix
    ./config/pegasus.nix
  ];

  dconf.settings = {
    "org/gnome/desktop/screensaver" = {
      lock-enabled = false;
      lock-on-suspend = false;
    };
  };
}
