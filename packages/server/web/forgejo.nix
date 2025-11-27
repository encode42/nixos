{
  hosts ? [ ],
}:

{
  config,
  lib,
  flakeLib,
  ...
}:

{
  imports = [
    ../databases/postgresql.nix
    ../databases/redis.nix
  ];

  services.redis.servers.forgejo = {
    enable = true;
    user = "forgejo";
  };

  services.forgejo = {
    enable = true;

    lfs = {
      enable = true;
    };

    database = {
      type = "postgres";

      socket = "/run/postgresql/";

      createDatabase = true;
    };

    settings = {
      service = {
        ENABLE_CAPTCHA = true;
        CAPTCHA_TYPE = "cfturnstile";

        DISABLE_REGISTRATION = true;

        REGISTER_EMAIL_CONFIRM = true;
        ENABLE_NOTIFY_MAIL = true;

        DEFAULT_KEEP_EMAIL_PRIVATE = true;
      };

      "repository.signing" = {
        DEFAULT_TRUST_MODEL = "committer";
      };

      #camo = {
      #  ENABLED = true;
      #};

      session = {
        PROVIDER = "redis";
        PROVIDER_CONFIG = "redis+socket://${config.services.redis.servers.forgejo.unixSocket}";

        COOKIE_SECURE = true;
      };

      queue = {
        TYPE = "redis";
        CONN_STR = "redis+socket://${config.services.redis.servers.forgejo.unixSocket}";
      };

      cache = {
        ADAPTER = "redis";
        HOST = "redis+socket://${config.services.redis.servers.forgejo.unixSocket}";
      };

      mailer = {
        ENABLED = true;
      };

      server = {
        DISABLE_SSH = true;

        PROTOCOL = "fcgi+unix";
      };

      "cron.update_checker" = {
        enabled = false;
      };
    };
  };

  # Required override for linux-hardened kernel
  systemd.services.forgejo.serviceConfig = {
    Type = lib.mkForce "exec";

    PrivateDevices = lib.mkForce false;
  };

  # Caddy reverse proxy configuration
  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy unix/${config.services.forgejo.settings.server.HTTP_ADDR} {
      transport fastcgi
    }
  '';
}
