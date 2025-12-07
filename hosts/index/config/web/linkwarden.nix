{ flakeRoot, ... }:

let
  linkwardenModule = import (flakeRoot + /packages/server/web/linkwarden.nix) {
    hosts = [
      {
        name = "linkwarden.lan";
        ssl = "internal";
      }
      {
        name = "archive.encrypted.group";
        ssl = "cloudflare";

        useLocal = true;
      }
    ];
  };
in
{
  imports = [
    linkwardenModule
  ];

  services.linkwarden = {
    port = 3113;

    storageLocation = "/mnt/data/linkwarden";

    environmentFile = "/mnt/apps/linkwarden/linkwarden.env";
  };
}
