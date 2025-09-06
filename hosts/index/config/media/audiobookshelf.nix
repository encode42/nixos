{ flakeRoot, ... }:

let
  audiobookshelfModule = import (flakeRoot + /packages/server/media/audiobookshelf.nix) {
    hosts = [
      {
        name = "audiobookshelf.lan";
        ssl = "internal";
      }
      {
        name = "read.encrypted.group";
        ssl = "cloudflare";
      }
    ];
  };
in
{
  imports = [
    audiobookshelfModule
  ];

  services.audiobookshelf = {
    dataDir = "/mnt/apps/audiobookshelf";
  };
}
