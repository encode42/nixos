{ flakeRoot, ... }:

let
  host = "knot.encrypted.group";

  tangledKnotModule = import (flakeRoot + /packages/server/atmosphere/tangled-knot.nix) {
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
    tangledKnotModule
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
