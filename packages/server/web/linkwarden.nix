{
  hosts ? [ ],
}:

{ config, flakeLib, ... }:

{
  services.linkwarden = {
    enable = true;

    host = "127.0.0.1";
  };

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :${toString config.services.linkwarden.port}
  '';
}
