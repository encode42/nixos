{
  flakeRoot,
  pkgs,
  ...
}:

{
  imports = [
    ./user.nix

    (flakeRoot + /packages/common/fish.nix)
  ];
}
