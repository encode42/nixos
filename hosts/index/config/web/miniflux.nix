{ flakeRoot, ... }:

let
  minifluxModule = import (flakeRoot + /packages/server/web/miniflux.nix) {
    hosts = [
      {
        name = "miniflux.lan";
        ssl = "internal";
      }
      {
        name = "feed.encrypted.group";
        ssl = "cloudflare";

        useLocal = true;
      }
    ];
  };
in
{
  imports = [
    minifluxModule
  ];

  services.miniflux.adminCredentialsFile = "/mnt/apps/miniflux/.miniflux.env";
}
