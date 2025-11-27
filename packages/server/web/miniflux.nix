{
  hosts ? [ ],
}:

{
  config,
  lib,
  flakeLib,
  ...
}:

{
  services.miniflux = {
    enable = true;

    config = {
      FILTER_ENTRY_MAX_AGE_DAYS = 7;

      FETCH_BILIBILI_WATCH_TIME = 1;
      FETCH_NEBULA_WATCH_TIME = 1;
      FETCH_ODYSEE_WATCH_TIME = 1;
      FETCH_YOUTUBE_WATCH_TIME = 1;

      MEDIA_PROXY_MODE = "all";

      CLEANUP_ARCHIVE_READ_DAYS = -1;
      CLEANUP_ARCHIVE_UNREAD_DAYS = -1;

      LISTEN_ADDR = "/run/miniflux/miniflux.sock";
    };
  };

  # Caddy reverse proxy configuration
  systemd.services.miniflux.serviceConfig.RuntimeDirectoryMode = lib.mkForce "0755";

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy unix/${config.services.miniflux.config.LISTEN_ADDR}
  '';
}
