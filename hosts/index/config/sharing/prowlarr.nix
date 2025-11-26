{ flakeRoot, ... }:

let
  prowlarrModule = import (flakeRoot + /packages/server/sharing/prowlarr.nix) {
    hosts = [
      {
        name = "prowlarr.lan";
        ssl = "internal";
      }
    ];
  };
in
{
  imports = [
    prowlarrModule
  ];

  services.prowlarr = {
    dataDir = "/mnt/apps/prowlarr";
  };
}
