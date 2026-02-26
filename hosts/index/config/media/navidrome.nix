{ flakeRoot, config, ... }:

let
  host = "hear.encrypted.group";

  navidromeModule = import (flakeRoot + /packages/server/media/navidrome.nix) {
    hosts = [
      {
        name = "navidrome.lan";
        ssl = "internal";
      }
      {
        name = host;
        ssl = "cloudflare";

        useLocal = true;
      }
    ];
  };

  service = config.services.navidrome;
in
{
  imports = [
    navidromeModule
  ];

  services.navidrome = {
    settings = {
      BaseURL = "https://${host}";

      DataFolder = "/mnt/apps/navidrome";
      MusicFolder = "/mnt/data/media/Music";
    };

    environmentFile = "/mnt/apps/navidrome/navidrome.env";
  };

  users.users.${service.user}.uid = 991;
  users.groups.${service.user}.gid = 974;
}
