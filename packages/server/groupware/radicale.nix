{
  hosts ? [ ],
}:

{ flakeLib, ... }:

{
  services.radicale = {
    enable = true;

    settings = {
      auth = {
        type = "imap";

        # imap_host = "localhost";
        # imap_security = "tls";

        cache_logins = true;
      };

      web = {
        type = "none";
      };
    };
  };

  # Caddy reverse proxy configuration
  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :5232
  '';
}
