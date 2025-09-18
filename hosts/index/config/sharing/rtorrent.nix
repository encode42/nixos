{
  flakeRoot,
  config,
  lib,
  ...
}:

let
  interface = "sh1";

  dhtPort = 6771;
  listenFromPort = 33101;
  listenToPort = 33103;

  vpnListenPorts = map (port: {
    inherit port;

    protocol = "both";
  }) (lib.range listenFromPort listenToPort);

  rtorrentModule = import (flakeRoot + /packages/server/sharing/rtorrent.nix) {
    inherit dhtPort;

    listenPortRange = {
      from = listenFromPort;
      to = listenToPort;
    };
  };

  floodModule = import (flakeRoot + /packages/server/sharing/flood.nix) {
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
    bridgeAddress = "192.168.15.7";

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
