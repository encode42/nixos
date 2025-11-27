{
  hosts ? [ ],
}:

{ config, flakeLib, ... }:

# TODO: Look into sockets

{
  services.omnipoly = {
    enable = true;
  };

  # Caddy reverse proxy configuration
  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :${toString config.services.omnipoly.port}
  '';
}
