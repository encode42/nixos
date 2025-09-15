{
  hosts ? [ ],
}:

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

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :5232
  '';
}
