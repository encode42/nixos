{
  hosts ? [ ],
  domain,
}:

{ flakeLib, ... }:

{
  services.go-autoconfig = {
    enable = true;

    settings = {
      domain = "autoconfig.${domain}";

      smtp = {
        server = "mx.${domain}";
      };

      imap = {
        server = "mx.${domain}";
      };
    };
  };

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :1323
  '';
}
