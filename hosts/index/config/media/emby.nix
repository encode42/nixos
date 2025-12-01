{ flakeRoot, ... }:

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
in
{
  imports = [
    embyModule
  ];

  services.emby = {
    dataDir = "/mnt/apps/emby";
  };
}
