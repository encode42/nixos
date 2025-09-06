{ flakeRoot, ... }:

{
  imports = [
    (flakeRoot + /packages/server/databases/postgresql.nix)
  ];

  services.postgresql = {
    dataDir = "/mnt/apps/postgres/data";
  };
}
