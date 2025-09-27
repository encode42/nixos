{
  lib,
  flakeRoot,
  pkgs,
  ...
}:

{
  imports = [
    (flakeRoot + /users/career)
  ];
}
