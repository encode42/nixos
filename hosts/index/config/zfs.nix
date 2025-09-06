{ flakeRoot, ... }:

{
  imports = [
    (flakeRoot + /modules/server/zfs.nix)
  ];

  networking.hostId = "c864ff4e";

  boot.zfs.extraPools = [
    "apps"
    "data"
  ];

  services.sanoid = {
    datasets = {
      # User data
      "data/pydio" = {
        useTemplate = [ "hourly" ];
      };

      "data/immich" = {
        useTemplate = [ "hourly" ];
      };

      "data/vaultwarden" = {
        useTemplate = [ "hourly" ];
      };

      # App data
      "apps/pydio" = {
        useTemplate = [ "daily" ];
      };

      "apps/vaultwarden" = {
        useTemplate = [ "daily" ];
      };

      # Databases
      "apps/postgresql" = {
        useTemplate = [ "vital" ];
      };

      "apps/mariadb" = {
        useTemplate = [ "vital" ];
      };
    };
  };
}
