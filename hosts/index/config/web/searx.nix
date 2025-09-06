{ flakeRoot, ... }:

let
  host = "search.encrypted.group";

  searxModule = import (flakeRoot + /packages/server/web/searx.nix) {
    hosts = [
      {
        name = "searx.lan";
        ssl = "internal";
      }
      {
        name = host;
        ssl = "cloudflare";
      }
    ];
  };
in
{
  imports = [
    searxModule
  ];

  services.searx = {
    environmentFile = "/mnt/apps/searx/searx.env";

    settings = {
      general = {
        instance_name = "encrypted group search";
      };

      server = {
        base_url = "https://${host}";
      };
    };
  };
}
