{
  flakeRoot,
  flakeLib,
  config,
  ...
}:

let
  mediaGroupName = config.users.groups.media.name;

  embySharePaths = [
    "Documentaries"
    "Live Performances"
    "Movies"
    "Music Videos"
    "Shows"
  ];

  embyShares = map (path: {
    path = "/mnt/data/media/${path}";

    userName = config.services.emby.user;
    groupName = mediaGroupName;
  }) embySharePaths;

  shares = [
    {
      name = "torrents";

      path = "/mnt/data/rtorrent/downloads";

      userName = config.services.rtorrent.user;
      groupName = mediaGroupName;
    }
    {
      name = "soulseek";

      path = "/mnt/data/soulseek/downloads";

      userName = config.services.slskd.user;
      groupName = mediaGroupName;
    }
    {
      path = "/mnt/data/media/Music";

      userName = config.services.navidrome.user;
      groupName = mediaGroupName;
    }
  ]
  ++ embyShares;
in
{
  imports = [
    (flakeRoot + /modules/server/filesystem/nfs.nix)

    (flakeLib.mkShares shares)
  ];

  services.nfs.server = {
    nproc = 16;
  };
}
