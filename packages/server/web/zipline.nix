{
  hosts ? [ ],
}:

{ config, flakeLib, ... }:

{
  services.zipline = {
    enable = true;

    settings = {
      URLS_ROUTE = "/";
      FILES_ROUTE = "/";

      URLS_LENGTH = 3;
      FILES_LENGTH = 3;

      FILES_MAX_FILE_SIZE = "500mb";

      CORE_PORT = 3030;

      FEATURES_USER_REGISTRATION = false;
      FEATURES_OAUTH_REGISTRATION = false;

      FEATURES_METRICS_ENABLED = false;

      FEATURES_VERSION_CHECKING = false;

      # https://zipline.diced.sh/docs/config/settings#variables-9
      # https://zipline.diced.sh/docs/config/settings#pwa
    };
  };

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :${toString config.services.zipline.settings.CORE_PORT}
  '';
}
