{ flakeRoot, ... }:

let
  host = "photos.encrypted.group";

  immichModule = import (flakeRoot + /packages/server/media/immich.nix) {
    hosts = [
      {
        name = "immich.lan";
        ssl = "internal";
      }
      {
        name = host;
        ssl = "cloudflare";

        useLocal = true;
      }
    ];
  };
in
{
  imports = [
    immichModule
  ];

  services.immich = {
    settings = {
      server = {
        externalDomain = "https://${host}";
      };
    };

    mediaLocation = "/mnt/data/immich";
  };

  systemd.services.immich-server.serviceConfig.ReadWritePaths = [ "/mnt/data/immich" ];
}
