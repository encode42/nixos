{
  hosts ? [ ],
}:

{
  config,
  flakeLib,
  lib,
  ...
}:

{
  services.bluesky-pds = {
    enable = true;

    settings = {
      # Assumes that the server is located in the northeastern Americas
      PDS_CRAWLERS = lib.concatStringsSep "," [
        "https://relay1.us-east.bsky.network"
        "https://relay.fire.hose.cam"
      ];
    };

    goat.enable = true;
  };

  services.caddy.virtualHosts = flakeLib.mkProxies hosts ''
    reverse_proxy :${toString config.services.bluesky-pds.settings.PDS_PORT}
  '';
}
