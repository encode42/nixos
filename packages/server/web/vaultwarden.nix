{
  hosts ? [ ],
}:

{ flakeLib, ... }:

let
  socket = "/run/vaultwarden/vaultwarden.sock";
in
{
  imports = [
    ../databases/postgresql.nix
  ];

  services.postgresql = {
    ensureUsers = [
      {
        name = "vaultwarden";
        ensureDBOwnership = true;
      }
    ];

    ensureDatabases = [ "vaultwarden" ];
  };

  services.vaultwarden = {
    enable = true;

    dbBackend = "postgresql";

    config = {
      ICON_SERVICE = "internal";
      ICON_REDIRECT_CODE = 301;

      SIGNUPS_VERIFY = true;
      REQUIRE_DEVICE_EMAIL = true;
      SMTP_EMBED_IMAGES = false;

      EMERGENCY_ACCESS_ALLOWED = false;
      PASSWORD_HINTS_ALLOWED = false;
      AUTHENTICATOR_DISABLE_TIME_DRIFT = true;

      INVITATIONS_ALLOWED = true;
      SIGNUPS_ALLOWED = false;

      TRASH_AUTO_DELETE_DAYS = 7;

      USER_ATTACHMENT_LIMIT = 51200;

      # TODO: look into websockets
      # TODO: look into push
      # TODO: HaveIBeenPwned API Key

      EXPERIMENTAL_CLIENT_FEATURE_FLAGS = "fido2-vault-credentials,simple-login-self-host-alias";

      EXTENDED_LOGGING = false;

      ROCKET_ADDRESS = "127.0.0.1"; # "unix:${socket}"; Supposedly, this is supported. However, it is not.
      DATABASE_URL = "postgresql:///vaultwarden?host=/run/postgresql";
    };
  };

  # Caddy reverse proxy configuration
  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :8000 # unix/${socket}
  '';
}
