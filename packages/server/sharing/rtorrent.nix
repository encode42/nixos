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

    # Unstable for rtorrent 0.16.3, roll back to stable once backported
    package = pkgs-unstable.rtorrent;

    configText = ''
      dht.mode.set = on
      dht.port.set = ${toString dhtPort}
      protocol.pex.set = yes
      trackers.use_udp.set = yes
      network.port_range.set = ${toString listenPortRange.from}-${toString listenPortRange.to}

      throttle.max_uploads.global.set = 300

      trackers.numwant.set = 100
      throttle.min_peers.normal.set = 1
      throttle.max_peers.normal.set = 100
      throttle.min_peers.seed.set = 1
      throttle.max_peers.seed.set = 100

      # Assumes a more powerful machine
      pieces.memory.max.set = 4000M
      pieces.preload.type.set = 2
      pieces.preload.min_rate.set = 30720

      # TODO: seeding ratio for sonarr/etc.
      #ratio.enable=
      #ratio.min.set=100
      #ratio.max.set=300
      #system.method.set = group.seeding.ratio.command, d.close=

      # Don't kill the internet
      schedule2 = throttle_download_limit_slow, 8:00:00, 24:00:00, ((throttle.max_downloads.global.set, 50))
      schedule2 = throttle_download_slow, 8:00:00, 24:00:00, ((throttle.global_down.max_rate.set_kb, 10240))
      schedule2 = throttle_upload_slow, 8:00:00, 24:00:00, ((throttle.global_up.max_rate.set_kb, 4096))

      schedule2 = throttle_download_limit_fast, 22:00:00, 24:00:00, ((throttle.max_downloads.global.set, 200))
      schedule2 = throttle_download_fast, 22:00:00, 24:00:00, ((throttle.global_down.max_rate.set_kb, 0))
      schedule2 = throttle_upload_fast, 22:00:00, 24:00:00, ((throttle.global_up.max_rate.set_kb, 0))

      # Compatibility with Flood
      method.redirect = load.throw,load.normal
      method.redirect = load.start_throw,load.start
      method.insert = d.down.sequential,value|const,0
      method.insert = d.down.sequential.set,value|const,0
    '';
  };

  networking.firewall = lib.mkIf openFirewall {
    allowedTCPPortRanges = [ listenPortRange ];
    allowedUDPPortRanges = [ listenPortRange ];
  };

  # Required override for linux-hardened kernel
  systemd.services.rtorrent.serviceConfig = {
    SystemCallFilter = lib.mkForce "@system-service";
  };

  # Add Flood to the rtorrent group for file management
  systemd.services.flood.serviceConfig.SupplementaryGroups = [ config.services.rtorrent.group ];

  # Caddy reverse proxy configuration
  users.users.caddy.extraGroups = [ config.services.rtorrent.group ];

  services.caddy.virtualHosts.rtorrent = {
    hostName = ":50000";

    listenAddresses = [
      "127.0.0.1"
      "::1"
    ];

    extraConfig = ''
      reverse_proxy unix/${config.services.rtorrent.rpcSocket} {
        transport scgi
      }
    '';
  };
}
