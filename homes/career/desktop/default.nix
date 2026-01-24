{ homeDesktop }:

{ flakeRoot, ... }:

{
  imports = [
    (import ./environments/gnome.nix { inherit homeDesktop; })

    (import ./firefox.nix { inherit homeDesktop; })

    (flakeRoot + /homes/shared/desktop/modrinth.nix)
    (flakeRoot + /homes/shared/desktop/prismlauncher.nix)

    ./packages.nix
  ];
}
