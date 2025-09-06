{ flakeRoot, ... }:

{
  imports = [
    (flakeRoot + /packages/server/media/emby.nix)
    {
      hosts = [
        {
          name = "emby.lan";
          ssl = "internal";
        }
        {
          name = "watch.encrypted.group";
          ssl = "cloudflare";
        }
      ];
    }
  ];

  services.emby = {
    dataDir = "/mnt/apps/emby";
  };
}
