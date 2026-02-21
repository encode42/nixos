{ flakeRoot, ... }:

let
  host = "deer.zip";

  ziplineModule = import (flakeRoot + /packages/server/web/zipline.nix) {
    hosts = [
      {
        name = host;
        ssl = "cloudflare";
      }
    ];
  };
in
{
  imports = [
    ziplineModule
  ];

  services.zipline = {
    environmentFiles = [ "/mnt/apps/zipline/.env" ];

    settings = {
      CORE_DEFAULT_DOMAIN = host;

      DATASOURCE_LOCAL_DIRECTORY = "/mnt/data/zipline/";
    };
  };
}
