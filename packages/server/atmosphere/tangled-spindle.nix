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
  port = 6555;
in
{
  services.tangled.spindle = {
    enable = true;

    server = {
      listenAddr = "0.0.0.0:${toString port}";

      maxJobCount = 3;
    };
  };

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :${toString port}
  '';
}
