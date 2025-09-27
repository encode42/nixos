{ flakeRoot, ... }:

{
  imports = [
    (flakeRoot + /modules/desktop/home-manager.nix)

    ./career.nix
    ./encode42.nix
  ];
}
