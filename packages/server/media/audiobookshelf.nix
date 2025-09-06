{
  hosts ? [ ],
}:

{ config, flakeLib, ... }:

{
  services.audiobookshelf = {
    enable = true;

    host = "unix//run/audiobookshelf/audiobookshelf.sock";
  };

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy ${config.services.audiobookshelf.host}
  '';
}
