{ flakeRoot, ... }:

let
  domain = "encrypted.group";

  maddyModule = import (flakeRoot + /packages/server/groupware/maddy.nix) {
    inherit domain;

    email = "postmaster@${domain}";

    ssl = "cloudflare";
  };
in
{
  imports = [
    maddyModule
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
