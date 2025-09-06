{ flakeRoot, ... }:

let
  soulseekModule = import (flakeRoot + /packages/server/torrenting/soulseek.nix) {
    hosts = [
      {
        name = "soulseek.lan";
        ssl = "internal";
      }
    ];
  };
in
{
  imports = [
    soulseekModule
  ];

  services.slskd = {
    settings = {
      instance_name = "index";

      directories = {
        incomplete = "/mnt/data/soulseek/incomplete";
        downloads = "/mnt/data/soulseek/downloads";
      };

      shares = {
        directories = [
          "[Music]/mnt/data/media/Music" # TODO
        ];
      };
    };

    environmentFile = "/mnt/apps/soulseek/soulseek.env";
  };
}
