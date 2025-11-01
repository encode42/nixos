{
  flakeRoot,
  ...
}:

{
  imports = [
    (flakeRoot + /users/career)
  ];
}
