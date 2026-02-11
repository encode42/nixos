{ flakeRoot, ... }:

let
  host = "spindle.encrypted.group";

  tangledSpindleModule = import (flakeRoot + /packages/server/atmosphere/tangled-spindle.nix) {
    hosts = [
      {
        name = host;
        ssl = "cloudflare";
      }
    ];
  };
in
{
  imports = [
    tangledSpindleModule
  ];

  services.tangled.spindle = {
    server = {
      hostname = host;

      owner = "did:plc:2uoarm26m6b24zqbq7h2kpqs";

      dbPath = "/mnt/apps/tangled/spindle.db";
    };
  };
}
