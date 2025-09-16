{
  flakeRoot,
  config,
  lib,
  ...
}:

let
  interface = "sh1";

  dhtPort = 6771;
  listenStartPort = 33101;
  listenEndPort = 33103;

  vpnListenPorts = map (port: {
    inherit port;

    protocol = "both";
  }) (lib.range listenStartPort listenEndPort);

  rtorrentModule = import (flakeRoot + /packages/server/torrenting/rtorrent.nix) {
    inherit dhtPort;

    listenPorts = {
      start = listenStartPort;
      end = listenEndPort;
    };
  };

  floodModule = import (flakeRoot + /packages/server/torrenting/flood.nix) {
    hosts = [
      {
        name = "rtorrent.lan";
        ssl = "internal";
      }
    ];
  };
in
{
  imports = [
    rtorrentModule
    floodModule
  ];

  vpnNamespaces.${interface} = {
    enable = true;

    wireguardConfigFile = "/mnt/apps/rtorrent/wg0.conf";

    namespaceAddress = "192.168.15.3";

    openVPNPorts = [
      {
        port = dhtPort;

        protocol = "both";
      }
    ]
    ++ vpnListenPorts;
  };

  services.rtorrent = {
    dataDir = "/mnt/apps/rtorrent";
    downloadDir = "/mnt/data/rtorrent/downloads";
  };

  systemd.services.rtorrent.vpnConfinement = {
    enable = true;

    vpnNamespace = interface;
  };
}
