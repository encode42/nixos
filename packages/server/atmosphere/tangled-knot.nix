{
  hosts ? [ ],
}:

{
  config,
  flakeLib,
  lib,
  ...
}:

let
  port = 5555;
in
{
  services.tangled.knot = {
    enable = true;

    server = {
      listenAddr = "0.0.0.0:${toString port}";
    };

    openFirewall = false;
  };

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :${toString port}
  '';
}
