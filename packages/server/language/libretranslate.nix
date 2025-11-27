{
  hosts ? [ ],
}:

{ config, flakeLib, ... }:

# TODO: Look into sockets

{
  services.libretranslate = {
    enable = true;

    environment = {
      LT_DISABLE_FILES_TRANSLATION = "true";
      LT_CHAR_LIMIT = "380";

      LT_THREADS = "8";
    };
  };

  # Caddy reverse proxy configuration
  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :${config.services.libretranslate.port}
  '';
}
