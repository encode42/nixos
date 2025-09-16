{
  dhtPort ? 6881,
  listenPortRange ? {
    from = 6881;
    to = 6889;
  },
  openFirewall ? false,
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
      # Disabled due to a bug in rtorrent 0.16
      dht.mode.set = off
      dht.port.set = ${toString dhtPort}
      protocol.pex.set = yes
      trackers.use_udp.set = yes
      network.port_range.set = ${toString listenPortRange.from}-${toString listenPortRange.to}

      throttle.max_downloads.set = 100
      throttle.max_uploads.global.set = 300

      trackers.numwant.set = 100
      throttle.min_peers.normal.set = 1
      throttle.max_peers.normal.set = 100
      throttle.min_peers.seed.set = 1
      throttle.max_peers.seed.set = 100

      # Assumes a more powerful machine
      pieces.memory.max.set = 4000M
      pieces.preload.type.set = 2
      pieces.preload.min_rate.set = 50000

      # TODO: seeding ratio for sonarr/etc.
      #ratio.enable=
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

  # Required override for linux-hardened kernel
  systemd.services.rtorrent.serviceConfig = {
    SystemCallFilter = lib.mkForce "@system-service";
  };

  networking.firewall = lib.mkIf openFirewall {
    allowedTCPPortRanges = [ listenPortRange ];
    allowedUDPPortRanges = [ listenPortRange ];
  };

  # Add Flood to the rtorrent group for file management
  systemd.services.flood.serviceConfig.SupplementaryGroups = [ config.services.rtorrent.group ];
}
