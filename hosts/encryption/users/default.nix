{ flakeRoot, ... }:

{
  imports = [
    (flakeRoot + /modules/desktop/home-manager.nix)

    ./encode42.nix
  ];
}
