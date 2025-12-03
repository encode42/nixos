{ flakeRoot, config, ... }:

let
  embyModule = import (flakeRoot + /packages/server/media/emby.nix) {
    hosts = [
      {
        name = "emby.lan";
        ssl = "internal";
      }
      {
        name = "watch.encrypted.group";
        ssl = "cloudflare";

        useLocal = true;
      }
    ];
  };

  service = config.services.emby;
in
{
  imports = [
    embyModule
  ];

  services.emby = {
    dataDir = "/mnt/apps/emby";
  };

  users.users.${service.user}.uid = 968;
  users.groups.${service.group}.gid = 965;
}
