{ flakeRoot, lib, pkgs-personal, ... }:

let
  host = "network-optimizer.lan";

  networkOptimizerModule = import (flakeRoot + /packages/server/web/network-optimizer.nix) {
    hosts = [
      {
        name = host;
        ssl = "internal";
      }
    ];
  };
in
{
  imports = [
    networkOptimizerModule
  ];

  services.network-optimizer = {
    environment = {
      REVERSE_PROXIED_HOST_NAME = host;
    };

    environmentFile = "/mnt/apps/network-optimizer/.env";
  };
}
