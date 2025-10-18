{ lib }:

hosts: proxy:

let
  caddyModulesPath = ../packages/server/caddy/modules;

  compressionModules = import (caddyModulesPath + /compression.nix);
  sslModules = import (caddyModulesPath + /ssl.nix);

  insertLocalSubdomain =
    host:
    let
      domainLevels = lib.splitString "." host;
      totalLevels = (lib.length domainLevels - 2);
    in
    lib.concatStringsSep "." (
      lib.take totalLevels domainLevels ++ [ "local" ] ++ lib.drop totalLevels domainLevels
    );
in
builtins.listToAttrs (
  map (host: {
    name = host.name;

    value = {
      serverAliases = lib.optional (host.useLocal or false) (insertLocalSubdomain host.name);

      extraConfig = ''
        ${compressionModules.basic}
        ${sslModules.${host.ssl}}

        ${proxy}
      '';
    };
  }) hosts
)
