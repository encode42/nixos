{
  hosts ? [ ],
}:

{ config, flakeLib, ... }:

{
  services.zipline = {
    enable = true;

    settings = {
      FILES_DEFAULT_EXPIRATION = "30d";
      FILES_REMOVE_GPS_METADATA = "true";

      URLS_ROUTE = "/";
      FILES_ROUTE = "/";

      URLS_LENGTH = 3;
      FILES_LENGTH = 3;

      FILES_MAX_FILE_SIZE = "500mb";
      FILES_DISABLED_EXTENSIONS = "exe,dmg,bat,bash,sh,html,htmx,html5";

      CORE_PORT = 3030;

      MFA_TOTP_ENABLED = "true";

      FEATURES_USER_REGISTRATION = "false";
      FEATURES_OAUTH_REGISTRATION = "false";

      FEATURES_HEALTHCHECK = "false";
      FEATURES_METRICS_ENABLED = "false";

      FEATURES_VERSION_CHECKING = "false";
    };
  };

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :${toString config.services.zipline.settings.CORE_PORT}
  '';
}
