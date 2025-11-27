{
  hosts ? [ ],
}:

{ config, flakeLib, ... }:

{
  services.audiobookshelf = {
    enable = true;

    host = "unix//run/audiobookshelf/audiobookshelf.sock";
  };

  systemd.services.audiobookshelf.serviceConfig = {
    RuntimeDirectory = config.services.audiobookshelf.user;
    RuntimeDirectoryMode = "0750";
    UMask = "0007";
  };

  # Caddy reverse proxy configuration
  users.users.caddy.extraGroups = [ config.services.audiobookshelf.group ];

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy ${config.services.audiobookshelf.host}
  '';
}
