{
  hosts ? [ ],
}:

{ config, flakeLib, ... }:

{
  imports = [
    ../databases/postgresql.nix
  ];

  services.wakapi = {
    enable = true;

    settings = {
      app = {
        leaderboard_enabled = false;

        inactive_days = 31;
        max_inactive_months = -1;
      };

      mail = {
        smtp = {
          port = 465;
          tls = true;
        };
      };

      server = {
        listen_ipv4 = "-";
        listen_ipv6 = "-";
        listen_socket = "/run/wakapi/wakapi.sock";
      };

      db = {
        user = "wakapi";
        name = "wakapi";

        dialect = config.services.wakapi.database.dialect;

        socket = "/run/postgres"; # config.services.postgresql.settings.socket; # TODO: This causes infinite recursion
      };

      security = {
        allow_signup = false;
        invite_codes = false;
        signup_captcha = true;

        disable_frontpage = true;

        insecure_cookies = false;
      };
    };

    database = {
      dialect = "postgres";

      createLocally = true;
    };
  };

  # Caddy reverse proxy configuration
  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy unix/${config.services.wakapi.settings.server.listen_socket}
  '';
}
