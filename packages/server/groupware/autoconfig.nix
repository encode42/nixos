{
  hosts ? [ ],
  domain,
}:

{ config, flakeLib, ... }:

{
  services.go-autoconfig = {
    enable = true;

    settings = {
      domain = "autoconfig.${domain}";

      smtp = {
        server = "mx.${domain}";
        port = 465;
      };

      imap = {
        server = "mx.${domain}";
        port = 993;
      };

      service_addr = ":1323";
    };
  };

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy ${config.services.go-autoconfig.settings.service_addr}
  '';
}
