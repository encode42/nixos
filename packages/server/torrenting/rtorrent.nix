{
  dhtPort ? 6881,
  listenPorts ? {
    start = 6881;
    end = 6889;
  },
}:

{
  config,
  pkgs-unstable,
  lib,
  ...
}:

{
  services.rtorrent = {
    enable = true;

    package = pkgs-unstable.rtorrent;

    configText = ''
      dht.mode.set = off
      dht.port.set = ${toString dhtPort}

      protocol.pex.set = yes

      trackers.use_udp.set = yes

      network.port_range.set = ${toString listenPorts.start}-${toString listenPorts.end}

      throttle.max_downloads.set = 100
      throttle.max_uploads.global.set = 300

      trackers.numwant.set = 100
      throttle.min_peers.normal.set = 1
      throttle.max_peers.normal.set = 100
      throttle.min_peers.seed.set = 1
      throttle.max_peers.seed.set = 100

      pieces.memory.max.set = 4000M
      pieces.preload.type.set = 2
      pieces.preload.min_rate.set = 50000

      #ratio.enable= # TODO: seeding ratio for sonarr/etc.
      #ratio.min.set=100
      #ratio.max.set=300
      #system.method.set = group.seeding.ratio.command, d.close=

      schedule2 = throttle_slow, 10:00:00, 24:00:00, ((throttle.global_up.max_rate.set_kb, 4000))

      # Compatibility with Flood
      method.redirect = load.throw,load.normal
      method.redirect = load.start_throw,load.start
      method.insert = d.down.sequential,value|const,0
      method.insert = d.down.sequential.set,value|const,0
    '';
  };

  systemd.services.rtorrent.serviceConfig = {
    SystemCallFilter = lib.mkForce "@system-service";
  };

  systemd.services.flood.serviceConfig.SupplementaryGroups = [ config.services.rtorrent.group ];
}
