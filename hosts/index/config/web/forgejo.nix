{ flakeRoot, ... }:

let
  host = "git.encrypted.group";

  forgejoModule = import (flakeRoot + /packages/server/web/forgejo.nix) {
    hosts = [
      {
        name = "forgejo.lan";
        ssl = "internal";
      }
      {
        name = host;
        ssl = "cloudflare";

        useLocal = true;
      }
    ];
  };
in
{
  imports = [
    forgejoModule
  ];

  services.forgejo = {
    stateDir = "/mnt/apps/forgejo";

    repositoryRoot = "/mnt/data/forgejo/repos";
    lfs.contentDir = "/mnt/data/forgejo/lfs";

    settings = {
      DEFAULT = {
        APP_NAME = "encrypted group forge";
      };

      service = {
        NO_REPLY_ADDRESS = "noreply.${host}";
      };

      mailer = {
        FROM = "git@encrypted.group";
        SMTP_PORT = 465;
      };

      server = {
        DOMAIN = "${host}";
        ROOT_URL = "https://${host}";
      };
    };

    secrets = {
      service = {
        CF_TURNSTILE_SITEKEY = "/mnt/apps/forgejo/secrets/turnstile_sitekey.env";
        CF_TURNSTILE_SECRET = "/mnt/apps/forgejo/secrets/turnstile_secret.env";
      };

      mailer = {
        SMTP_ADDR = "/mnt/apps/forgejo/secrets/smtp_address.env";
        USER = "/mnt/apps/forgejo/secrets/smtp_user.env";
        PASSWD = "/mnt/apps/forgejo/secrets/smtp_password.env";
      };
    };
  };
}
