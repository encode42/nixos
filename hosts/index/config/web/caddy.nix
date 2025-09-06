{ flakeRoot, ... }:

let
  caddyModule = import (flakeRoot + /packages/server/caddy) {
    email = "postmaster@encrypted.group";
  };
in
{
  imports = [
    caddyModule
  ];

  services.caddy = {
    environmentFile = "/mnt/apps/caddy/caddy.env";
  };
}
