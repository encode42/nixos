hosts: proxy:

let
  caddyModulesPath = ../packages/server/caddy/modules;

  compressionModules = import (caddyModulesPath + /compression.nix);
  sslModules = import (caddyModulesPath + /ssl.nix);
in
builtins.listToAttrs (
  map (host: {
    name = host.name;
    value = {
      extraConfig = ''
        ${compressionModules.basic}
        ${sslModules.${host.ssl}}

        ${proxy}
      '';
    };
  }) hosts
)
