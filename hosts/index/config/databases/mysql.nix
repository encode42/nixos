{ flakeRoot, ... }:

{
  imports = [
    (flakeRoot + /packages/server/databases/mysql.nix)
  ];

  services.mysql = {
    dataDir = "/mnt/apps/mariadb";
  };
}
