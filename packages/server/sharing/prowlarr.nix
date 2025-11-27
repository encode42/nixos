{
  hosts ? [ ],
}:

{
  config,
  pkgs-unstable,
  flakeLib,
  ...
}:

let
  prowlarrModulePath = "services/misc/servarr/prowlarr.nix";
in
{
  # Unstable to use dataDir option, roll back to stable once 25.11 releases
  disabledModules = [ prowlarrModulePath ];
  imports = [ "${pkgs-unstable.path}/nixos/modules/${prowlarrModulePath}" ];

  services.prowlarr = {
    enable = true;
  };

  # Caddy reverse proxy configuration
  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :${toString config.services.prowlarr.settings.server.port}
  '';
}
