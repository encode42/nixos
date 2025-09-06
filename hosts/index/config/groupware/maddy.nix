{ flakeRoot, ... }:

let
  domain = "encrypted.group";

  maddyModule = import (flakeRoot + /packages/server/groupware/maddy.nix) {
    inherit domain;

    email = "postmaster@${domain}";
  };

  autoconfigModule = import (flakeRoot + /packages/server/groupware/autoconfig.nix) {
    inherit domain;

    hosts = [
      {
        name = "autoconfig.${domain}";
        ssl = "cloudflare";
      }
    ];
  };
in
{
  imports = [
    maddyModule
    autoconfigModule
  ];

  services.maddy = {
    hostname = domain;

    localDomains = [
      "erora.live"
      "encode42.dev"
    ];

    secrets = [
      "/mnt/apps/maddy/secrets/cloudflare_token.env"
    ];
  };

  services.rspamd-trainer.secrets = [
    "/mnt/apps/rspamd/.rspamd-trainer.env"
  ];
}
