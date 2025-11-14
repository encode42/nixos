{ email }:

{ pkgs, ... }:

{
  services.caddy = {
    enable = true;

    inherit email;

    enableReload = false;

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

      hash = "sha256-rOhVN9afti73MBrpleVH+Qmh1hj6N8flOySIq9nUxGU=";
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
