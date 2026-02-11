{ flakeRoot, ... }:

let
  host = "knot.encrypted.group";

  tangledModule = import (flakeRoot + /packages/server/atmosphere/tangled.nix) {
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
    tangledModule
  ];

  services.tangled.knot = {
    stateDir = "/mnt/apps/tangled";

    repo = {
      scanPath = "/mnt/data/tangled";
    };

    server = {
      hostname = host;

      owner = "did:plc:2uoarm26m6b24zqbq7h2kpqs";
    };
  };
}
