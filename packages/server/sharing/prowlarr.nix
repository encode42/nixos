{
  hosts ? [ ],
}:

{
  config,
  flakeLib,
  ...
}:

{
  imports = [
    ./byparr.nix
  ];

  services.prowlarr = {
    enable = true;
  };

  # Caddy reverse proxy configuration
  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :${toString config.services.prowlarr.settings.server.port}
  '';
}
