{
  hosts ? [ ],
}:

{ config, flakeLib, ... }:

{
  services.linkwarden = {
    enable = true;
  };

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :${toString config.services.linkwarden.port}
  '';
}
