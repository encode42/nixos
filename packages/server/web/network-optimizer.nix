{
  hosts ? [ ],
}:

{
  config,
  lib,
  flakeLib,
  ...
}:

{
  services.network-optimizer = {
    enable = true;

    environment = {
      BIND_LOCALHOST_ONLY = true;
    };
  };

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :${config.services.network-optimizer.port}
  '';
}
