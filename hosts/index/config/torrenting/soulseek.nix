{ flakeRoot, config, ... }:

let
  interface = "sh0";

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

    namespaceAddress = "192.168.15.2";

    portMappings = [
      {
        from = config.services.slskd.settings.web.port;
        to = config.services.slskd.settings.web.port;
      }
    ];

    accessibleFrom = [ "127.0.0.1" ];

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

  users.users.${config.services.slskd.user}.extraGroups = [ "media" ];
}
