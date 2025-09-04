{ flakeRoot, ... }:

{
  imports = [
    (flakeRoot + /packages/desktop/steam.nix)
    (flakeRoot + /packages/desktop/dolphin.nix)
  ];
}