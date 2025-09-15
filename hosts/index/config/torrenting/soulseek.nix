{ flakeRoot, config, ... }:

let
  interface = "soulsk";

  port = 50220;

  soulseekModule = import (flakeRoot + /packages/server/torrenting/soulseek.nix) {
    hosts = [
      {
        name = "soulseek.lan";
        ssl = "internal";
      }
    ];

    interface = config.vpnNamespaces.${interface}.namespaceAddress;
  };
in
{
  imports = [
    soulseekModule
  ];

  vpnNamespaces.${interface} = {
    enable = true;

    portMappings = [
      { from = config.services.slskd.settings.web.port; to = config.services.slskd.settings.web.port; }
    ];

    openVPNPorts = [
      {
        inherit port;
      }
    ];

    wireguardConfigFile = "/mnt/apps/soulseek/wg0.conf";
  };

  services.slskd = {
    settings = {
      instance_name = "index";

      directories = {
        incomplete = "/mnt/data/soulseek/incomplete";
        downloads = "/mnt/data/soulseek/downloads";
      };

      shares = {
        directories = [
          "[Music]/mnt/data/media/Music"
        ];
      };

      soulseek = {
        listen_port = port;
      };
    };

    environmentFile = "/mnt/apps/soulseek/soulseek.env";
  };

  systemd.services.slskd.vpnConfinement = {
    enable = true;

    vpnNamespace = interface;
  };
}
