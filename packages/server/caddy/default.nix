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

      order scgi after reverse_proxy
    '';

    package = pkgs.caddy.withPlugins {
      plugins = [
        "github.com/caddy-dns/cloudflare@v0.2.1"
        "github.com/WeidiDeng/caddy-cloudflare-ip@v0.0.0-20231130002422-f53b62aa13cb"
        "github.com/BadAimWeeb/caddy-uwsgi-transport@v0.0.0-20240317192154-74a1008b9763"
        "github.com/Elegant996/scgi-transport@v1.1.6"
      ];

      hash = "sha256-QNDVztTcO66k47eFb5b0OyOfnCHuI5ret8Dwk7t+gSY=";
    };
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
