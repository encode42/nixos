{ flakeRoot, ... }:

let
  host = "vault.encrypted.group";

  vaultwardenModule = import (flakeRoot + /packages/server/web/vaultwarden.nix) {
    hosts = [
      {
        name = "vaultwarden.lan";
        ssl = "internal";
      }
      {
        name = host;
        ssl = "cloudflare";
      }
    ];
  };
in
{
  imports = [
    vaultwardenModule
  ];

  services.vaultwarden = {
    config = {
      DOMAIN = "https://${host}";
      INVITATION_ORG_NAME = "encrypted group vault";

      DATA_FOLDER = "/mnt/apps/vaultwarden";

      ATTACHMENTS_FOLDER = "/mnt/data/vaultwarden/attachments";
      SENDS_FOLDER = "/mnt/data/vaultwarden/sends";
    };

    environmentFile = "/mnt/apps/vaultwarden/vaultwarden.env"; # TODO: Make sure to swap out
  };
}
