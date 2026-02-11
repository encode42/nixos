{ flakeRoot, lib, ... }:

let
  host = "encrypted.group";

  blueskyPdsModule = import (flakeRoot + /packages/server/atmosphere/bluesky-pds.nix) {
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
    blueskyPdsModule
  ];

  services.bluesky-pds = {
    environmentFiles = [ "/mnt/apps/bluesky-pds/.env" ];

    settings = {
      PDS_HOSTNAME = host;

      PDS_SERVICE_HANDLE_DOMAINS = lib.concatStringsSep "," [
        ".${host}"
        ".encode42.dev"
        ".erora.live"
      ];
    };
  };
}
