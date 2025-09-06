{ flakeRoot, ... }:

let
  floodModule = import (flakeRoot + /packages/server/torrenting/flood.nix) {
    hosts = [
      {
        name = "rtorrent.lan";
        ssl = "internal";
      }
    ];
  };
in
{
  imports = [
    (flakeRoot + /packages/server/torrenting/rtorrent.nix)

    floodModule
  ];

  services.rtorrent = {
    dataDir = "/mnt/apps/rtorrent";
    downloadDir = "/mnt/data/rtorrent/downloads";
  };
}
