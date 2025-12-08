{
  config,
  lib,
  isLaptop,
  ...
}:

let
  normalUsers = lib.attrValues (
    lib.filterAttrs (_: user: user.isSystemUser == false) config.users.users
  );
in
{
  programs.gamemode = {
    enable = true;

    settings = {
      general.renice = 10;

      gpu.apply_gpu_optimizations = lib.mkIf isLaptop "accept-responsibility";
    };
  };

  users.groups.gamemode.members = map (user: user.name) normalUsers;
}
