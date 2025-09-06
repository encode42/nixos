{ email }:

{ pkgs, ... }:

{
  services.caddy = {
    enable = true;

    inherit email;

    globalConfig = ''
      servers {
        trusted_proxies cloudflare {
          interval 12h
          timeout 15s
        }
      }
    '';

    package = pkgs.caddy.withPlugins {
      plugins = [
        "github.com/caddy-dns/cloudflare@v0.2.1"
        "github.com/WeidiDeng/caddy-cloudflare-ip@v0.0.0-20231130002422-f53b62aa13cb"
        "github.com/BadAimWeeb/caddy-uwsgi-transport@v0.0.0-20240317192154-74a1008b9763"
      ];

      hash = "sha256-THbBk1z14F6LhsI8feUgZxCPIFehLXlNkpxidl0soYc=";
    };
  };
}
