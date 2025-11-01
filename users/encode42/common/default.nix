{
  flakeRoot,
  ...
}:

{
  imports = [
    ./user.nix

    (flakeRoot + /packages/common/fish.nix)
    (flakeRoot + /packages/common/git.nix)
  ];
}
