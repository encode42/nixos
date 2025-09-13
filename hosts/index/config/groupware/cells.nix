{ flakeRoot, ... }:

let
  cellsModule = import (flakeRoot + /packages/server/groupware/cells.nix) {
    hosts = [
      {
        name = "cells.lan";
        ssl = "internal";
      }
      {
        name = "drive.encrypted.group";
        ssl = "cloudflare";
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

  systemd.services.cells.serviceConfig.ReadWritePaths = [ "/mnt/apps/pydio" "/mnt/data/pydio" ];
}
