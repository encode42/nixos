{ flakeRoot, config, ... }:

let
  interface = "sh0";

  port = 50220;

  soulseekModule = import (flakeRoot + /packages/server/sharing/soulseek.nix) {
    hosts = [
      {
        name = "soulseek.lan";
        ssl = "internal";
      }
    ];
  };

  service = config.services.slskd;
in
{
  imports = [
    soulseekModule
  ];

  vpnNamespaces.${interface} = {
    enable = true;

    namespaceAddress = "192.168.15.2";
    bridgeAddress = "192.168.15.6";

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
        listen_ip_address = config.vpnNamespaces.${interface}.namespaceAddress;
        listen_port = port;
      };
    };

    environmentFile = "/mnt/apps/soulseek/soulseek.env";
  };

  systemd.services.slskd.vpnConfinement = {
    enable = true;

    vpnNamespace = interface;
  };

  users.users.${service.user} = {
    uid = 985;

    extraGroups = [ "media" ];
  };

  users.groups.${service.group}.gid = 973;
}
