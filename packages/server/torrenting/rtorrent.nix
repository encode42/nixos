{
  services.rtorrent = {
    enable = true;

    configText = ''
      dht.mode.set = auto
      dht.port.set = "6881"

      protocol.pex.set = yes

      network.port_range.set = "6881-6889"

      trackers.use_udp.set = yes

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
    '';
  };
}
