{ flakeRoot, ... }:

let
  wakapiModule = import (flakeRoot + /packages/server/web/wakapi.nix) {
    hosts = [
      {
        name = "wakapi.lan";
        ssl = "internal";
      }
    ];
  };
in
{
  imports = [
    wakapiModule
  ];

  services.wakapi = {
    passwordSaltFile = "/mnt/apps/wakapi/wakapi.env";
  };
}
