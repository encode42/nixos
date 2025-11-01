{ flakeRoot, ... }:

{
  imports = [
    (flakeRoot + /packages/desktop/winboat.nix)
  ];

  users.users.career.extraGroups = [
    "docker"
  ];
}
