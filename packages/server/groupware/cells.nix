{
  hosts ? [ ],
}:

{ config, flakeLib, ... }:

{
  imports = [
    ./collabora.nix
  ];

  services.cells = {
    enable = true;
  };

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :${toString config.services.cells.port} {
      transport http {
        tls
        tls_insecure_skip_verify
      }
    }
  '';
}
