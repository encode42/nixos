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
    RuntimeDirectory = "audiobookshelf";
    RuntimeDirectoryMode = "0750";
    UMask = "0007";
  };

  users.users.caddy.extraGroups = [ "audiobookshelf" ];

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy ${config.services.audiobookshelf.host}
  '';
}
