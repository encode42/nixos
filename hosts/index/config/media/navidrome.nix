{ flakeRoot, ... }:

let
  navidromeModule = import (flakeRoot + /packages/server/media/navidrome.nix) {
    hosts = [
      {
        name = "navidrome.lan";
        ssl = "internal";
      }
      {
        name = "listen.encrypted.group";
        ssl = "cloudflare";
      }
    ];
  };
in
{
  imports = [
    navidromeModule
  ];

  services.navidrome = {
    settings = {
      DataFolder = "/mnt/apps/navidrome";
      MusicFolder = "/mnt/data/media/Music";
    };

    environmentFile = "/mnt/apps/navidrome/navidrome.env";
  };
}
