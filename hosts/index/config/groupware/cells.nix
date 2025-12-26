{ flakeRoot, ... }:

let
  hostname = "drive.encrypted.group";
  localHostname = "drive.local.encrypted.group"; # TODO: this can change

  cellsModule = import (flakeRoot + /packages/server/groupware/cells.nix) {
    hosts = [
      {
        name = "cells.lan";
        ssl = "internal";
      }
      {
        name = hostname;
        ssl = "cloudflare";

        useLocal = true;
      }
    ];
  };

  cellsHome = "/mnt/apps/pydio";
in
{
  imports = [
    cellsModule
  ];

  services.cells = {
    environment = {
      HOME = cellsHome;

      CELLS_WORKING_DIR = cellsHome;
      CELLS_CONFIG = "file://${cellsHome}/pydio.json";
    };
  };

  systemd.services.cells.serviceConfig.ReadWritePaths = [
    "/mnt/apps/pydio"
    "/mnt/data/pydio"
  ];

  services.collabora-online = {
    aliasGroups = [ { host = "https://${hostname}:443"; } { host = "https://${localHostname}:443"; } ]; # TODO: messy
  };
}
